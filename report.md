# Vaccine Research and Development Database — Report Draft

## 1. Problem statement
Vaccine R&D produces linked information about vaccine candidates, antigens, formulations,
manufacturing batches, studies, research sites, anonymized participants, adverse events,
and laboratory tests. A relational database is useful for maintaining these relationships
and enforcing data integrity.

## 2. Scope
The database stores synthetic educational records for vaccine candidates from preclinical
through clinical development and post-marketing phases. It does not store direct personal
identifiers or real patient data.

## 3. Entities
- VaccineCandidate
- Antigen
- CandidateAntigen
- Formulation
- Batch
- Study
- StudyPhase
- Site
- StudySite
- Participant
- StudyParticipant
- AdverseEvent
- LabTest

## 4. Important relationships
- VaccineCandidate 1:M Formulation
- Formulation 1:M Batch
- VaccineCandidate 1:M Study
- StudyPhase 1:M Study
- VaccineCandidate M:N Antigen through CandidateAntigen
- Study M:N Site through StudySite
- Study M:N Participant through StudyParticipant
- StudyParticipant 1:M AdverseEvent
- StudyParticipant 1:M LabTest

## 5. Normalization
The design separates independent facts into separate tables. Repeating groups are removed,
many-to-many relationships are resolved through associative tables, and non-key attributes
depend on the key of their own table. The resulting design is intended to satisfy 3NF.

## 6. Constraints and integrity
Primary keys uniquely identify records. Foreign keys enforce valid relationships.
Unique constraints prevent duplicate codes. CHECK constraints validate age, quantities,
dates, and enrollment values. A trigger prevents a batch from being inserted with an
invalid expiry date.

## 7. Views
`vw_candidate_pipeline` summarizes candidates and their number of studies.
`vw_study_safety_summary` summarizes participant enrollment and adverse events by study.

## 8. Advanced database object
`trg_batch_dates` enforces the batch date business rule.
`sp_study_enrollment` reports current enrollment and remaining study capacity.

## 9. Test data
All data in `load_data.sql` is synthetic and intended only for educational testing.

## 10. Conclusion
The database provides a structured relational model for vaccine R&D information and
demonstrates the required database lifecycle: requirements, conceptual design,
relational mapping, implementation, loading, querying, views, advanced database logic,
and testing.
