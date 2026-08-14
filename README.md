# Vaccine Research and Development Database

A relational MySQL database for managing vaccine candidates, antigens, formulations,
batches, preclinical/clinical studies, sites, anonymized participants, adverse events,
and laboratory tests.

## Project topic
**Vaccine Research and Development Database** — Topic 3 from the Biotechnology Database Project Guidelines.

The design follows the required project scope: meaningful entities, 1:M and M:N
relationships, normalization to at least 3NF, DDL, test data, SQL operations, two views,
and a trigger.

## DBMS
MySQL 8.0+

## Repository structure
```text
Vaccine_RnD_Database/
├── README.md
├── report.md
├── sql/
│   ├── create_tables.sql
│   ├── load_data.sql
│   ├── queries.sql
│   ├── views.sql
│   └── triggers_procedures.sql
├── diagrams/
│   └── ERD.png
└── src/
    └── .gitkeep
```

## Main entities
1. VaccineCandidate
2. Antigen
3. CandidateAntigen (associative table)
4. Formulation
5. Batch
6. Study
7. Site
8. Participant
9. StudyParticipant (associative table)
10. AdverseEvent
11. LabTest
12. StudyPhase

## Key business rules
- Each vaccine candidate has a unique candidate code.
- A candidate can contain multiple antigens, and an antigen can be used in multiple candidates.
- Each formulation belongs to one vaccine candidate.
- Each batch belongs to one formulation.
- A study belongs to one vaccine candidate and one study phase.
- A study can use multiple sites; a site can host multiple studies.
- A participant can join multiple studies, while a study can have multiple participants.
- Participant identifiers are anonymized; no direct personal identifiers are stored.
- An adverse event must belong to a study participant.
- A laboratory test belongs to a study participant.
- Batch expiry must be later than manufacture date.

## How to run
1. Install MySQL 8.0+.
2. Open MySQL Workbench or another MySQL client.
3. Run `sql/create_tables.sql`.
4. Run `sql/load_data.sql`.
5. Run `sql/views.sql`.
6. Run `sql/triggers_procedures.sql`.
7. Run `sql/queries.sql` to demonstrate retrieval, joins, aggregation, subqueries,
   INSERT, UPDATE, DELETE, and the database views/trigger.

All supplied records are **synthetic test data** created for the educational project.

## GitHub
Create a public repository, upload this folder, and commit the files. The GitHub
repository should contain the same structure shown above.

## Academic integrity
This project is a database design template with synthetic data. Review, understand,
adapt, and acknowledge any material used in the final submission according to the
course guidelines.
