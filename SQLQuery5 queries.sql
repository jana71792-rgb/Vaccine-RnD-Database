USE vaccine_rnd_db;
GO



SELECT *
FROM VaccineCandidate
WHERE development_stage IN ('Phase II', 'Phase III');
GO




SELECT
    vc.candidate_name,
    s.study_code,
    s.study_status
FROM VaccineCandidate vc
JOIN Study s
    ON vc.candidate_id = s.candidate_id
ORDER BY vc.candidate_name;
GO




SELECT
    development_stage,
    COUNT(*) AS candidate_count
FROM VaccineCandidate
GROUP BY development_stage
ORDER BY candidate_count DESC;
GO




SELECT
    vc.candidate_name,
    a.antigen_name,
    ca.antigen_role,
    ca.dose_mcg
FROM CandidateAntigen ca
JOIN VaccineCandidate vc
    ON ca.candidate_id = vc.candidate_id
JOIN Antigen a
    ON ca.antigen_id = a.antigen_id
ORDER BY vc.candidate_name;
GO



SELECT candidate_name
FROM VaccineCandidate
WHERE candidate_id IN (
    SELECT candidate_id
    FROM Study
    GROUP BY candidate_id
    HAVING COUNT(*) > 1
);
GO



SELECT
    test_type,
    AVG(result_value) AS average_result
FROM LabTest
GROUP BY test_type;
GO



SELECT
    s.study_code,
    COUNT(ae.adverse_event_id) AS total_events
FROM Study s
LEFT JOIN AdverseEvent ae
    ON s.study_id = ae.study_id
GROUP BY
    s.study_id,
    s.study_code
ORDER BY total_events DESC;
GO



INSERT INTO Participant
    (anonymized_code, age, sex, screening_status)
VALUES
    ('P-TEST', 34, 'F', 'Eligible');
GO



UPDATE Participant
SET screening_status = 'Screened'
WHERE anonymized_code = 'P-TEST';
GO



DELETE FROM Participant
WHERE anonymized_code = 'P-TEST';
GO



SELECT *
FROM vw_candidate_pipeline;
GO




SELECT *
FROM vw_study_safety_summary;
GO




EXEC sp_study_enrollment 1;
GO
