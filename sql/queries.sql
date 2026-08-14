USE vaccine_rnd_db;

-- 1. Basic retrieval
SELECT * FROM VaccineCandidate
WHERE development_stage IN ('Phase II','Phase III');

-- 2. JOIN: candidates and their studies
SELECT vc.candidate_name, s.study_code, s.study_status
FROM VaccineCandidate vc
JOIN Study s ON vc.candidate_id = s.candidate_id
ORDER BY vc.candidate_name;

-- 3. Aggregation: number of studies per development stage
SELECT development_stage, COUNT(*) AS candidate_count
FROM VaccineCandidate
GROUP BY development_stage
ORDER BY candidate_count DESC;

-- 4. M:N relationship: candidate antigens
SELECT vc.candidate_name, a.antigen_name, ca.antigen_role, ca.dose_mcg
FROM CandidateAntigen ca
JOIN VaccineCandidate vc ON ca.candidate_id = vc.candidate_id
JOIN Antigen a ON ca.antigen_id = a.antigen_id
ORDER BY vc.candidate_name;

-- 5. Nested query: candidates with more than one study
SELECT candidate_name
FROM VaccineCandidate
WHERE candidate_id IN (
    SELECT candidate_id
    FROM Study
    GROUP BY candidate_id
    HAVING COUNT(*) > 1
);

-- 6. Aggregation: average lab result by test type
SELECT test_type, AVG(result_value) AS average_result
FROM LabTest
GROUP BY test_type;

-- 7. Safety query
SELECT s.study_code, COUNT(ae.adverse_event_id) AS total_events
FROM Study s
LEFT JOIN AdverseEvent ae ON s.study_id = ae.study_id
GROUP BY s.study_id, s.study_code
ORDER BY total_events DESC;

-- 8. INSERT test
INSERT INTO Participant (anonymized_code,age,sex,screening_status)
VALUES ('P-TEST',34,'F','Eligible');

-- 9. UPDATE test
UPDATE Participant
SET screening_status = 'Screened'
WHERE anonymized_code = 'P-TEST';

-- 10. DELETE test
DELETE FROM Participant
WHERE anonymized_code = 'P-TEST';

-- 11. View 1
SELECT * FROM vw_candidate_pipeline;

-- 12. View 2
SELECT * FROM vw_study_safety_summary;

-- 13. Stored procedure
CALL sp_study_enrollment(1);

-- 14. Trigger test: this should fail intentionally
-- INSERT INTO Batch
-- (formulation_id,batch_code,manufacture_date,expiry_date,quantity,quality_status)
-- VALUES (1,'B-INVALID','2026-08-01','2026-07-01',100,'Released');
