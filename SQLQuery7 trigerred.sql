USE vaccine_rnd_db;
GO


/* ============================================================
   1. TRIGGER: Validate Batch Dates
   ============================================================ */

CREATE TRIGGER trg_batch_dates
ON Batch
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE expiry_date <= manufacture_date
    )
    BEGIN
        THROW 50001, 'Expiry date must be later than manufacture date', 1;
    END
END;
GO


/* ============================================================
   2. STORED PROCEDURE: Study Enrollment
   ============================================================ */

CREATE PROCEDURE sp_study_enrollment
    @p_study_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        s.study_code,
        s.study_title,
        s.target_enrollment,
        COUNT(sp.participant_id) AS current_enrollment,
        s.target_enrollment - COUNT(sp.participant_id) AS remaining_slots
    FROM Study s
    LEFT JOIN StudyParticipant sp
        ON s.study_id = sp.study_id
    WHERE s.study_id = @p_study_id
    GROUP BY
        s.study_id,
        s.study_code,
        s.study_title,
        s.target_enrollment;
END;
GO