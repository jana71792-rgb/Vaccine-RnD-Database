DROP DATABASE IF EXISTS vaccine_rnd_db;
CREATE DATABASE vaccine_rnd_db;
USE vaccine_rnd_db;

CREATE TABLE StudyPhase (
    phase_id INT PRIMARY KEY AUTO_INCREMENT,
    phase_name VARCHAR(30) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE VaccineCandidate (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_code VARCHAR(20) NOT NULL UNIQUE,
    candidate_name VARCHAR(100) NOT NULL,
    platform VARCHAR(60) NOT NULL,
    target_disease VARCHAR(100) NOT NULL,
    development_stage VARCHAR(40) NOT NULL,
    sponsor_name VARCHAR(120) NOT NULL,
    first_development_date DATE NOT NULL
);

CREATE TABLE Antigen (
    antigen_id INT PRIMARY KEY AUTO_INCREMENT,
    antigen_name VARCHAR(100) NOT NULL UNIQUE,
    antigen_type VARCHAR(60) NOT NULL,
    source_organism VARCHAR(100) NOT NULL,
    target_protein VARCHAR(100) NOT NULL
);

CREATE TABLE CandidateAntigen (
    candidate_id INT NOT NULL,
    antigen_id INT NOT NULL,
    antigen_role VARCHAR(60) NOT NULL,
    dose_mcg DECIMAL(8,2),
    PRIMARY KEY (candidate_id, antigen_id),
    FOREIGN KEY (candidate_id) REFERENCES VaccineCandidate(candidate_id),
    FOREIGN KEY (antigen_id) REFERENCES Antigen(antigen_id)
);

CREATE TABLE Formulation (
    formulation_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    formulation_code VARCHAR(30) NOT NULL UNIQUE,
    adjuvant VARCHAR(100),
    route VARCHAR(40) NOT NULL,
    dose_volume_ml DECIMAL(6,2) NOT NULL,
    storage_temperature VARCHAR(30) NOT NULL,
    FOREIGN KEY (candidate_id) REFERENCES VaccineCandidate(candidate_id)
);

CREATE TABLE Batch (
    batch_id INT PRIMARY KEY AUTO_INCREMENT,
    formulation_id INT NOT NULL,
    batch_code VARCHAR(30) NOT NULL UNIQUE,
    manufacture_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    quantity INT NOT NULL,
    quality_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (formulation_id) REFERENCES Formulation(formulation_id),
    CHECK (quantity > 0),
    CHECK (expiry_date > manufacture_date)
);

CREATE TABLE Site (
    site_id INT PRIMARY KEY AUTO_INCREMENT,
    site_code VARCHAR(20) NOT NULL UNIQUE,
    site_name VARCHAR(120) NOT NULL,
    city VARCHAR(80) NOT NULL,
    country VARCHAR(80) NOT NULL,
    site_type VARCHAR(50) NOT NULL
);

CREATE TABLE Study (
    study_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT NOT NULL,
    phase_id INT NOT NULL,
    study_code VARCHAR(30) NOT NULL UNIQUE,
    study_title VARCHAR(180) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    study_status VARCHAR(30) NOT NULL,
    target_enrollment INT NOT NULL,
    FOREIGN KEY (candidate_id) REFERENCES VaccineCandidate(candidate_id),
    FOREIGN KEY (phase_id) REFERENCES StudyPhase(phase_id),
    CHECK (target_enrollment > 0),
    CHECK (end_date IS NULL OR end_date >= start_date)
);

CREATE TABLE StudySite (
    study_id INT NOT NULL,
    site_id INT NOT NULL,
    planned_enrollment INT NOT NULL,
    PRIMARY KEY (study_id, site_id),
    FOREIGN KEY (study_id) REFERENCES Study(study_id),
    FOREIGN KEY (site_id) REFERENCES Site(site_id),
    CHECK (planned_enrollment > 0)
);

CREATE TABLE Participant (
    participant_id INT PRIMARY KEY AUTO_INCREMENT,
    anonymized_code VARCHAR(30) NOT NULL UNIQUE,
    age INT NOT NULL,
    sex CHAR(1) NOT NULL,
    screening_status VARCHAR(30) NOT NULL,
    CHECK (age BETWEEN 18 AND 80),
    CHECK (sex IN ('F','M','O'))
);

CREATE TABLE StudyParticipant (
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    treatment_group VARCHAR(40) NOT NULL,
    completion_status VARCHAR(30) NOT NULL,
    PRIMARY KEY (study_id, participant_id),
    FOREIGN KEY (study_id) REFERENCES Study(study_id),
    FOREIGN KEY (participant_id) REFERENCES Participant(participant_id)
);

CREATE TABLE AdverseEvent (
    adverse_event_id INT PRIMARY KEY AUTO_INCREMENT,
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(80) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    outcome VARCHAR(40) NOT NULL,
    FOREIGN KEY (study_id, participant_id)
        REFERENCES StudyParticipant(study_id, participant_id)
);

CREATE TABLE LabTest (
    lab_test_id INT PRIMARY KEY AUTO_INCREMENT,
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    test_date DATE NOT NULL,
    test_type VARCHAR(80) NOT NULL,
    result_value DECIMAL(10,2),
    unit VARCHAR(30),
    result_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (study_id, participant_id)
        REFERENCES StudyParticipant(study_id, participant_id)
);

CREATE INDEX idx_study_candidate ON Study(candidate_id);
CREATE INDEX idx_batch_formulation ON Batch(formulation_id);
CREATE INDEX idx_ae_participant ON AdverseEvent(participant_id);
CREATE INDEX idx_lab_participant ON LabTest(participant_id);
