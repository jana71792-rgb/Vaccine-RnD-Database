USE vaccine_rnd_db;

CREATE OR REPLACE VIEW vw_candidate_pipeline AS
SELECT
    vc.candidate_code,
    vc.candidate_name,
    vc.platform,
    vc.target_disease,
    vc.development_stage,
    COUNT(DISTINCT s.study_id) AS study_count
FROM VaccineCandidate vc
LEFT JOIN Study s ON vc.candidate_id = s.candidate_id
GROUP BY vc.candidate_id, vc.candidate_code, vc.candidate_name,
         vc.platform, vc.target_disease, vc.development_stage;

CREATE OR REPLACE VIEW vw_study_safety_summary AS
SELECT
    s.study_code,
    s.study_title,
    COUNT(DISTINCT sp.participant_id) AS enrolled_participants,
    COUNT(ae.adverse_event_id) AS adverse_events,
    SUM(CASE WHEN ae.severity = 'Moderate' THEN 1 ELSE 0 END) AS moderate_events,
    SUM(CASE WHEN ae.severity = 'Severe' THEN 1 ELSE 0 END) AS severe_events
FROM Study s
LEFT JOIN StudyParticipant sp ON s.study_id = sp.study_id
LEFT JOIN AdverseEvent ae
    ON sp.study_id = ae.study_id AND sp.participant_id = ae.participant_id
GROUP BY s.study_id, s.study_code, s.study_title;
