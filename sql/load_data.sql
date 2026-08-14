USE vaccine_rnd_db;

INSERT INTO StudyPhase (phase_name, description) VALUES
('Preclinical','Laboratory and animal evaluation before human trials'),
('Phase I','Initial human safety and dose evaluation'),
('Phase II','Expanded safety and preliminary efficacy evaluation'),
('Phase III','Large-scale efficacy and safety evaluation'),
('Phase IV','Post-marketing surveillance');

INSERT INTO VaccineCandidate
(candidate_code,candidate_name,platform,target_disease,development_stage,sponsor_name,first_development_date) VALUES
('VC001','VaxNova-Alpha','mRNA','Respiratory Virus A','Phase I','NovaBio Research','2025-01-15'),
('VC002','ImmunoShield-2','Protein subunit','Respiratory Virus B','Phase II','Immunex Labs','2024-09-20'),
('VC003','VectorSafe-3','Viral vector','Hemorrhagic Fever C','Preclinical','VectorGen','2025-03-11'),
('VC004','CoroGuard-4','mRNA','Coronavirus D','Phase III','BioShield','2023-06-05'),
('VC005','FluNext-5','Protein subunit','Influenza E','Phase II','MediCore','2024-02-14'),
('VC006','TB-Prime-6','DNA','Tuberculosis','Preclinical','Global Immunology','2025-05-18'),
('VC007','HPV-Protect-7','VLP','HPV-associated disease','Phase III','OncoVax','2022-11-09'),
('VC008','RSV-Guard-8','Protein subunit','RSV infection','Phase II','RespiraTech','2024-07-01'),
('VC009','MalaVax-9','Viral vector','Malaria','Phase I','TropiGene','2025-02-22'),
('VC010','NoroBlock-10','Virus-like particle','Norovirus','Preclinical','EnteroBio','2025-06-30');

INSERT INTO Antigen (antigen_name,antigen_type,source_organism,target_protein) VALUES
('Antigen A1','Recombinant protein','Virus A','Surface glycoprotein'),
('Antigen B1','Recombinant protein','Virus B','Capsid protein'),
('Antigen C1','Viral vector expressed','Virus C','Envelope protein'),
('Antigen D1','mRNA encoded','Coronavirus D','Spike protein'),
('Antigen E1','Recombinant protein','Influenza E','Hemagglutinin'),
('Antigen F1','DNA encoded','Mycobacterium tuberculosis','Antigen 85B'),
('Antigen G1','VLP','HPV','L1 protein'),
('Antigen H1','Recombinant protein','RSV','F protein'),
('Antigen I1','Viral vector expressed','Plasmodium falciparum','Circumsporozoite protein'),
('Antigen J1','VLP','Norovirus','Capsid protein');

INSERT INTO CandidateAntigen VALUES
(1,1,'Primary antigen',50),(2,2,'Primary antigen',75),(3,3,'Primary antigen',100),
(4,4,'Primary antigen',30),(5,5,'Primary antigen',60),(6,6,'Primary antigen',80),
(7,7,'Primary antigen',40),(8,8,'Primary antigen',50),(9,9,'Primary antigen',90),
(10,10,'Primary antigen',70),(1,2,'Supporting antigen',15),(4,1,'Supporting antigen',10);

INSERT INTO Formulation
(candidate_id,formulation_code,adjuvant,route,dose_volume_ml,storage_temperature) VALUES
(1,'F-VC001-A','Lipid nanoparticle','Intramuscular',0.50,'-20 C'),
(2,'F-VC002-A','Alum','Intramuscular',0.50,'2-8 C'),
(3,'F-VC003-A','None','Intramuscular',0.50,'2-8 C'),
(4,'F-VC004-A','Lipid nanoparticle','Intramuscular',0.30,'-70 C'),
(5,'F-VC005-A','MF59','Intramuscular',0.50,'2-8 C'),
(6,'F-VC006-A','CpG','Intradermal',0.20,'2-8 C'),
(7,'F-VC007-A','Alum','Intramuscular',0.50,'2-8 C'),
(8,'F-VC008-A','AS01','Intramuscular',0.50,'2-8 C'),
(9,'F-VC009-A','None','Intramuscular',0.50,'2-8 C'),
(10,'F-VC010-A','Alum','Intramuscular',0.50,'2-8 C');

INSERT INTO Batch
(formulation_id,batch_code,manufacture_date,expiry_date,quantity,quality_status) VALUES
(1,'B001','2026-01-10','2027-01-10',5000,'Released'),
(2,'B002','2026-01-15','2027-01-15',4500,'Released'),
(3,'B003','2026-02-01','2027-02-01',3000,'Under review'),
(4,'B004','2026-02-10','2027-02-10',6000,'Released'),
(5,'B005','2026-02-20','2027-02-20',5200,'Released'),
(6,'B006','2026-03-01','2027-03-01',2500,'Under review'),
(7,'B007','2026-03-15','2027-03-15',7000,'Released'),
(8,'B008','2026-04-01','2027-04-01',4800,'Released'),
(9,'B009','2026-04-12','2027-04-12',3500,'Quarantined'),
(10,'B010','2026-05-05','2027-05-05',4000,'Released');

INSERT INTO Site
(site_code,site_name,city,country,site_type) VALUES
('S001','Central Clinical Research Center','Cairo','Egypt','Hospital'),
('S002','Alexandria Vaccine Unit','Alexandria','Egypt','Hospital'),
('S003','North Research Institute','Giza','Egypt','Research Institute'),
('S004','Mediterranean Medical Center','Alexandria','Egypt','Hospital'),
('S005','Delta Trial Site','Mansoura','Egypt','Clinic'),
('S006','Upper Egypt Research Hub','Asyut','Egypt','Research Institute'),
('S007','Nile University Trial Unit','Giza','Egypt','University'),
('S008','Red Sea Clinical Center','Hurghada','Egypt','Hospital'),
('S009','Capital Immunology Center','Cairo','Egypt','Clinic'),
('S010','Canal Research Hospital','Ismailia','Egypt','Hospital');

INSERT INTO Study
(candidate_id,phase_id,study_code,study_title,start_date,end_date,study_status,target_enrollment) VALUES
(1,2,'ST001','Safety and dose study of VaxNova-Alpha','2026-02-01',NULL,'Recruiting',60),
(2,3,'ST002','Immunogenicity study of ImmunoShield-2','2025-10-01',NULL,'Recruiting',120),
(3,1,'ST003','Preclinical evaluation of VectorSafe-3','2025-07-01','2026-01-30','Completed',30),
(4,4,'ST004','Efficacy study of CoroGuard-4','2024-03-01',NULL,'Active',500),
(5,3,'ST005','Dose optimization of FluNext-5','2025-05-15',NULL,'Active',150),
(6,1,'ST006','Preclinical TB-Prime-6 assessment','2025-08-10','2026-03-20','Completed',40),
(7,4,'ST007','Large-scale HPV-Protect-7 study','2023-05-01',NULL,'Active',800),
(8,3,'ST008','RSV-Guard-8 immunogenicity trial','2025-01-10',NULL,'Active',180),
(9,2,'ST009','Phase I MalaVax-9 safety trial','2026-03-05',NULL,'Recruiting',70),
(10,1,'ST010','Preclinical NoroBlock-10 evaluation','2026-01-20',NULL,'Active',35);

INSERT INTO StudySite VALUES
(1,1,30),(1,9,30),(2,1,60),(2,2,60),(3,3,30),(4,1,250),(4,2,250),
(5,4,75),(5,5,75),(6,6,40),(7,7,400),(7,9,400),(8,8,90),(8,10,90),
(9,1,35),(9,3,35),(10,5,20),(10,6,15);

INSERT INTO Participant (anonymized_code,age,sex,screening_status) VALUES
('P-0001',24,'F','Eligible'),('P-0002',31,'M','Eligible'),('P-0003',45,'F','Eligible'),
('P-0004',52,'M','Eligible'),('P-0005',29,'F','Eligible'),('P-0006',38,'M','Eligible'),
('P-0007',61,'F','Eligible'),('P-0008',47,'M','Eligible'),('P-0009',33,'F','Eligible'),
('P-0010',56,'M','Eligible'),('P-0011',40,'F','Eligible'),('P-0012',27,'M','Eligible');

INSERT INTO StudyParticipant VALUES
(1,1,'2026-02-05','Dose A','Ongoing'),(1,2,'2026-02-06','Dose B','Ongoing'),
(2,3,'2025-10-08','Vaccine','Ongoing'),(2,4,'2025-10-09','Placebo','Completed'),
(4,5,'2024-03-12','Vaccine','Ongoing'),(4,6,'2024-03-14','Placebo','Ongoing'),
(5,7,'2025-05-20','Vaccine','Ongoing'),(8,8,'2025-01-15','Vaccine','Completed'),
(9,9,'2026-03-10','Dose A','Ongoing'),(9,10,'2026-03-11','Dose B','Ongoing'),
(7,11,'2023-05-12','Vaccine','Completed'),(10,12,'2026-01-25','Control','Ongoing');

INSERT INTO AdverseEvent
(study_id,participant_id,event_date,event_type,severity,outcome) VALUES
(1,1,'2026-02-07','Injection-site pain','Mild','Resolved'),
(1,2,'2026-02-08','Headache','Mild','Resolved'),
(2,3,'2025-10-12','Fatigue','Mild','Resolved'),
(2,4,'2025-10-14','Fever','Moderate','Resolved'),
(4,5,'2024-03-18','Fever','Mild','Resolved'),
(4,6,'2024-03-20','Headache','Mild','Resolved'),
(5,7,'2025-05-24','Injection-site swelling','Mild','Resolved'),
(8,8,'2025-01-20','Fatigue','Mild','Resolved'),
(9,9,'2026-03-15','Nausea','Mild','Ongoing'),
(9,10,'2026-03-16','Fever','Moderate','Resolved');

INSERT INTO LabTest
(study_id,participant_id,test_date,test_type,result_value,unit,result_status) VALUES
(1,1,'2026-02-07','Neutralizing antibody',1250,'AU/mL','Within range'),
(1,2,'2026-02-08','Neutralizing antibody',1180,'AU/mL','Within range'),
(2,3,'2025-10-20','Antibody titer',980,'AU/mL','Within range'),
(2,4,'2025-10-20','Antibody titer',210,'AU/mL','Within range'),
(4,5,'2024-04-01','Antibody titer',1450,'AU/mL','Within range'),
(4,6,'2024-04-01','Antibody titer',320,'AU/mL','Within range'),
(5,7,'2025-06-01','Antibody titer',1120,'AU/mL','Within range'),
(8,8,'2025-02-01','Neutralizing antibody',870,'AU/mL','Within range'),
(9,9,'2026-03-25','Neutralizing antibody',760,'AU/mL','Within range'),
(9,10,'2026-03-25','Neutralizing antibody',815,'AU/mL','Within range'),
(7,11,'2023-06-01','Antibody titer',1600,'AU/mL','Within range'),
(10,12,'2026-02-10','Antibody titer',95,'AU/mL','Below target');
