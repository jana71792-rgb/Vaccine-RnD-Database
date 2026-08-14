USE vaccine_rnd_db;

DELIMITER $$

CREATE TRIGGER trg_batch_dates
BEFORE INSERT ON Batch
FOR EACH ROW
BEGIN
    IF NEW.expiry_date <= NEW.manufacture_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Expiry date must be later than manufacture date';
    END IF;
END$$

CREATE PROCEDURE sp_study_enrollment(IN p_study_id INT)
BEGIN
    SELECT
        s.study_code,
        s.study_title,
        s.target_enrollment,
        COUNT(sp.participant_id) AS current_enrollment,
        s.target_enrollment - COUNT(sp.participant_id) AS remaining_slots
    FROM Study s
    LEFT JOIN StudyParticipant sp ON s.study_id = sp.study_id
    WHERE s.study_id = p_study_id
    GROUP BY s.study_id, s.study_code, s.study_title, s.target_enrollment;
END$$

DELIMITER ;
