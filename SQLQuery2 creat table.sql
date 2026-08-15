/* ============================================================
   VACCINE RESEARCH & DEVELOPMENT DATABASE
   SQL SERVER / T-SQL VERSION
   ============================================================ */

-- ============================================================
-- 1. DROP DATABASE IF IT ALREADY EXISTS
-- ============================================================

IF DB_ID('vaccine_rnd_db') IS NOT NULL
BEGIN
    ALTER DATABASE vaccine_rnd_db
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE vaccine_rnd_db;
END;
GO


-- ============================================================
-- 2. CREATE DATABASE
-- ============================================================

CREATE DATABASE vaccine_rnd_db;
GO


-- ============================================================
-- 3. USE DATABASE
-- ============================================================

USE vaccine_rnd_db;
GO


-- ============================================================
-- 4. STUDY PHASE
-- ============================================================

CREATE TABLE StudyPhase (
    phase_id INT PRIMARY KEY IDENTITY(1,1),
    phase_name VARCHAR(30) NOT NULL UNIQUE,
    description VARCHAR(255)
);
GO


-- ============================================================
-- 5. VACCINE CANDIDATE
-- ============================================================

CREATE TABLE VaccineCandidate (
    candidate_id INT PRIMARY KEY IDENTITY(1,1),
    candidate_code VARCHAR(20) NOT NULL UNIQUE,
    candidate_name VARCHAR(100) NOT NULL,
    platform VARCHAR(60) NOT NULL,
    target_disease VARCHAR(100) NOT NULL,
    development_stage VARCHAR(40) NOT NULL,
    sponsor_name VARCHAR(120) NOT NULL,
    first_development_date DATE NOT NULL
);
GO


-- ============================================================
-- 6. ANTIGEN
-- ============================================================

CREATE TABLE Antigen (
    antigen_id INT PRIMARY KEY IDENTITY(1,1),
    antigen_name VARCHAR(100) NOT NULL UNIQUE,
    antigen_type VARCHAR(60) NOT NULL,
    source_organism VARCHAR(100) NOT NULL,
    target_protein VARCHAR(100) NOT NULL
);
GO


-- ============================================================
-- 7. CANDIDATE ANTIGEN
-- Many-to-Many relationship between VaccineCandidate and Antigen
-- ============================================================

CREATE TABLE CandidateAntigen (
    candidate_id INT NOT NULL,
    antigen_id INT NOT NULL,
    antigen_role VARCHAR(60) NOT NULL,
    dose_mcg DECIMAL(8,2),

    PRIMARY KEY (candidate_id, antigen_id),

    CONSTRAINT FK_CandidateAntigen_Candidate
        FOREIGN KEY (candidate_id)
        REFERENCES VaccineCandidate(candidate_id),

    CONSTRAINT FK_CandidateAntigen_Antigen
        FOREIGN KEY (antigen_id)
        REFERENCES Antigen(antigen_id)
);
GO


-- ============================================================
-- 8. FORMULATION
-- ============================================================

CREATE TABLE Formulation (
    formulation_id INT PRIMARY KEY IDENTITY(1,1),
    candidate_id INT NOT NULL,
    formulation_code VARCHAR(30) NOT NULL UNIQUE,
    adjuvant VARCHAR(100),
    route VARCHAR(40) NOT NULL,
    dose_volume_ml DECIMAL(6,2) NOT NULL,
    storage_temperature VARCHAR(30) NOT NULL,

    CONSTRAINT FK_Formulation_Candidate
        FOREIGN KEY (candidate_id)
        REFERENCES VaccineCandidate(candidate_id)
);
GO


-- ============================================================
-- 9. BATCH
-- ============================================================

CREATE TABLE Batch (
    batch_id INT PRIMARY KEY IDENTITY(1,1),
    formulation_id INT NOT NULL,
    batch_code VARCHAR(30) NOT NULL UNIQUE,
    manufacture_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    quantity INT NOT NULL,
    quality_status VARCHAR(30) NOT NULL,

    CONSTRAINT FK_Batch_Formulation
        FOREIGN KEY (formulation_id)
        REFERENCES Formulation(formulation_id),

    CONSTRAINT CK_Batch_Quantity
        CHECK (quantity > 0),

    CONSTRAINT CK_Batch_Dates
        CHECK (expiry_date > manufacture_date)
);
GO


-- ============================================================
-- 10. SITE
-- ============================================================

CREATE TABLE Site (
    site_id INT PRIMARY KEY IDENTITY(1,1),
    site_code VARCHAR(20) NOT NULL UNIQUE,
    site_name VARCHAR(120) NOT NULL,
    city VARCHAR(80) NOT NULL,
    country VARCHAR(80) NOT NULL,
    site_type VARCHAR(50) NOT NULL
);
GO


-- ============================================================
-- 11. STUDY
-- ============================================================

CREATE TABLE Study (
    study_id INT PRIMARY KEY IDENTITY(1,1),
    candidate_id INT NOT NULL,
    phase_id INT NOT NULL,
    study_code VARCHAR(30) NOT NULL UNIQUE,
    study_title VARCHAR(180) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    study_status VARCHAR(30) NOT NULL,
    target_enrollment INT NOT NULL,

    CONSTRAINT FK_Study_Candidate
        FOREIGN KEY (candidate_id)
        REFERENCES VaccineCandidate(candidate_id),

    CONSTRAINT FK_Study_Phase
        FOREIGN KEY (phase_id)
        REFERENCES StudyPhase(phase_id),

    CONSTRAINT CK_Study_Enrollment
        CHECK (target_enrollment > 0),

    CONSTRAINT CK_Study_Dates
        CHECK (end_date IS NULL OR end_date >= start_date)
);
GO


-- ============================================================
-- 12. STUDY SITE
-- Many-to-Many relationship between Study and Site
-- ============================================================

CREATE TABLE StudySite (
    study_id INT NOT NULL,
    site_id INT NOT NULL,
    planned_enrollment INT NOT NULL,

    PRIMARY KEY (study_id, site_id),

    CONSTRAINT FK_StudySite_Study
        FOREIGN KEY (study_id)
        REFERENCES Study(study_id),

    CONSTRAINT FK_StudySite_Site
        FOREIGN KEY (site_id)
        REFERENCES Site(site_id),

    CONSTRAINT CK_StudySite_Enrollment
        CHECK (planned_enrollment > 0)
);
GO


-- ============================================================
-- 13. PARTICIPANT
-- ============================================================

CREATE TABLE Participant (
    participant_id INT PRIMARY KEY IDENTITY(1,1),
    anonymized_code VARCHAR(30) NOT NULL UNIQUE,
    age INT NOT NULL,
    sex CHAR(1) NOT NULL,
    screening_status VARCHAR(30) NOT NULL,

    CONSTRAINT CK_Participant_Age
        CHECK (age BETWEEN 18 AND 80),

    CONSTRAINT CK_Participant_Sex
        CHECK (sex IN ('F', 'M', 'O'))
);
GO


-- ============================================================
-- 14. STUDY PARTICIPANT
-- Many-to-Many relationship between Study and Participant
-- ============================================================

CREATE TABLE StudyParticipant (
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    treatment_group VARCHAR(40) NOT NULL,
    completion_status VARCHAR(30) NOT NULL,

    PRIMARY KEY (study_id, participant_id),

    CONSTRAINT FK_StudyParticipant_Study
        FOREIGN KEY (study_id)
        REFERENCES Study(study_id),

    CONSTRAINT FK_StudyParticipant_Participant
        FOREIGN KEY (participant_id)
        REFERENCES Participant(participant_id)
);
GO


-- ============================================================
-- 15. ADVERSE EVENT
-- ============================================================

CREATE TABLE AdverseEvent (
    adverse_event_id INT PRIMARY KEY IDENTITY(1,1),
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(80) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    outcome VARCHAR(40) NOT NULL,

    CONSTRAINT FK_AdverseEvent_StudyParticipant
        FOREIGN KEY (study_id, participant_id)
        REFERENCES StudyParticipant(study_id, participant_id)
);
GO


-- ============================================================
-- 16. LAB TEST
-- ============================================================

CREATE TABLE LabTest (
    lab_test_id INT PRIMARY KEY IDENTITY(1,1),
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    test_date DATE NOT NULL,
    test_type VARCHAR(80) NOT NULL,
    result_value DECIMAL(10,2),
    unit VARCHAR(30),
    result_status VARCHAR(30) NOT NULL,

    CONSTRAINT FK_LabTest_StudyParticipant
        FOREIGN KEY (study_id, participant_id)
        REFERENCES StudyParticipant(study_id, participant_id)
);
GO


-- ============================================================
-- 17. INDEXES
-- ============================================================

CREATE INDEX idx_study_candidate
ON Study(candidate_id);
GO

CREATE INDEX idx_batch_formulation
ON Batch(formulation_id);
GO

CREATE INDEX idx_ae_participant
ON AdverseEvent(participant_id);
GO

CREATE INDEX idx_lab_participant
ON LabTest(participant_id);
GO


-- ============================================================
-- 18. VERIFY TABLES
-- ============================================================

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO
