/*
****PLEASE NOTE THAT THIS PROJECT IS NOT BASED ON A REAL BUSINESS CASE
BUT A HUPOTHETICAL SCENARIO ONLY***
*/
--Part one create tables
--1. Candidate
create table Candidate (
candidate_id    varchar(20),
candidate_name  varchar(20),
phone_number    varchar(20),
address         varchar(100),
date_of_birth   date,
income          number,
loan_agent_id   varchar(20),
status_type     varchar(50)
)
;

--2. Demographic Status
create table Demographic_Status (
status_type            varchar(40),
average_income         number,
region                 varchar(50),
gender_ratio           number
)
;

--3. Loan
create table Loan (
loan_id         varchar(20),
loan_type  varchar(50),
amount      number,
loan_interest number,
score           number,
loan_status varchar(20)
)
;  

--4.Loan Application Form
create table Loan_Application_Form( 
form_number             varchar(20),
candidate_id            varchar(20),
amount_requested        number,
submission_date         date,
phone_connection_info   varchar(20),
rent_mortgage_info      varchar(20),
proof_of_character      varchar(20),
loan_ID                 varchar(20)
)
;

--5.Bank
create table Bank(
branch_id                    varchar(20),
data_report                  varchar(20),
decision_rendering_algorithm varchar(20),
budget_for_MFI               number,
loan_approval_rate           number
)
;

--6. Loan Agents
create table Loan_Agents (
loan_agent_id     varchar(20),
branch_id         varchar(20),
title             varchar(20),
service_specialty varchar(90)
)
;

--7. Type
create table Type (
loan_type        varchar(50),
term_limit       number
)
;

--Part two alter the table with primary keys anf foreign keys
--1. Loan Agents
alter table Loan_Agents
add constraint loan_agents_pk1 primary key(loan_agent_id)
;

--2. Demographic Staus
alter table Demographic_Status
add constraint demographic_status_pk1 primary key(status_type)
;

--3. Candidate
alter table Candidate
add constraint candidate_pk1 primary key(candidate_id)
add constraint candidate_fk1 foreign key(loan_agent_id) references Loan_Agents(loan_agent_id)
add constraint candidate_fk2 foreign key(status_type) references Demographic_Status(status_type)
;

--4.Loan_Application_Form
alter table Loan_Application_Form
add constraint loan_application_form_pk1 primary key(form_number)
add constraint loan_application_form_fk1 foreign key(candidate_id) references Candidate(candidate_id)
;

--5.Bank 
alter table Bank
add constraint bank_pk1 primary key(branch_id)
;

--6. Loan
alter table Loan
add constraint loan_pk1 primary key(loan_id)
add constraint loan_fk1 foreign key(loan_type) references Type(loan_type)
;

--7. Type
alter table Type
add constraint type_pk1 primary key(loan_type)
;

--Part three insert records
--1. Candidate
insert into Candidate values ('CA1234560', 'Maria',	'8297234557', 
'4th B Cross, Anepalya, Neelasandra, Bengaluru, Karnataka 560030, India', 
'7-FEB-75', 543, 'LA 002', 'Low Income and High Population Density')
;
insert into Candidate values ('CA1234561', 'Sophia',	'8297234558', 
'Bazaar St, Rose Garden, Vannarpet Layout, Viveka Nagar, Bengaluru, Karnataka 560047, India', 
'9-SEP-80', 567, 'LA 005', 'Low Income and Low Population Density')
;
insert into Candidate values ('CA1234562', 'Christina',	'8297234559', 
'NH 211, Gajanan Nagar, Georai, Maharashtra 431127, India', 
'13-AUG-77', 643, 'LA 009', 'High Income and High Population Density')
;
insert into Candidate values ('CA1234563', 'Vinusha',	'8297234560', 
'Manyarwadi Rd, Georai, Maharashtra 431127, India', 
'8-JUN-80', 432, 'LA 003', 'High Income and Low Population Density')
;
insert into Candidate values ('CA1234564', 'Ravali',	'8297234561', 
'arya nagar, nizamabad, telangana, 503230', 
'16-JUL-70', 559, 'LA 001', 'Low Income and Low Population Density')
;
insert into Candidate values ('CA1234565', 'Rama',	'9988456710', 
'jubliee jhills, hyderabad, telangana, 500033', 
'28-AUG-85', 765, 'LA 004', 'High Income and High Population Density')
;
insert into Candidate values ('CA1234566', 'Ishi',	'9010056789', 
'New Delhi, Delhi 110037, India', 
'13-JUL-90', 854, 'LA 006', 'Low Income and High Population Density')
;
insert into Candidate values ('CA1234567', 'Celestine',	'8297234556', 
'Plot No.6, North, Pocket 1, Sector 14 Dwarka, Dwarka, Delhi, 110075, India', 
'30-SEP-88', 356, 'LA 003', 'Low Income and Low Population Density')
;
insert into Candidate values ('CA1234568', 'Meili',	'9100812345', 
'487, Malik Para, Dum Dum Park, South Dumdum, West Bengal 700055, India', 
'20-JAN-70', 777, 'LA 002', 'Low Income and High Population Density')
;
insert into Candidate values ('CA1234569', 'Lily',	'7890123456', 
'1060 Hope St, Providence, RI 02906', 
'10-OCT-91', 678, 'LA 001', 'Low Income and High Population Density')
;
select * from Candidate
;

--2. Demographic Status
insert into Demographic_Status values ('Low Income and High Population Density', 666, 'Eastern India', 0.51)
;
insert into Demographic_Status values ('Low Income and Low Population Density', 732, 'Central and Northeastern India', 0.48)
;
insert into Demographic_Status values ('High Income and High Population Density', 999, 'Northern and Southern India', 0.49)
;
insert into Demographic_Status values ('High Income and Low Population Density', 1332, 'Western India', 0.5)
;
select * from Demographic_Status
;

--3. Loan
insert into Loan values ('LO 1211', 'Term Loans', 5000, 0.05, 87, 'Paid off')
;
insert into Loan values ('LO 1212', 'SBA Loans', 3000, 0.05, 79, 'Authorized')
;
insert into Loan values ('LO 1213', 'Business lines of credit', 2000,  0.05, 82, 'Disbursed')
;
insert into Loan values ('LO 1214', 'Equipment Loans', 700,  0.05, 78, 'Authorized')
;
insert into Loan values ('LO 1215', 'Invoice Factoring and Invoice Financing', 500,  0.05, 91, 'Disbursed')
;
insert into Loan values ('LO 1216', 'Microloans', 400,  0.05, 77, 'Disbursed')
;
insert into Loan values ('LO 1217', 'Merchant Cash Advances', 500, 0.05, 80, 'Authorized')
;
insert into Loan values ('LO 1218', 'Term Loans', 1200, 0.05, 75, 'Paid off')
;
insert into Loan values ('LO 1219', 'Business lines of credit', 2000,  0.05, 85, 'Paid off')
;
insert into Loan values ('LO 1220', 'Invoice Factoring and Invoice Financing', 2000,  0.05, 90, 'Authorized')
;
select * from Loan
;

--4.Loan_Application_Form
insert into Loan_Application_Form values ('AA223350', 'CA1234560', 5000, '01-NOV-19', 'yes', 'yes', 'no', 'LO 1211')
;
insert into Loan_Application_Form values ('AA223351', 'CA1234561', 3000, '17-DEC-19', 'yes', 'no', 'no', 'LO 1212')
;
insert into Loan_Application_Form values ('AA223352', 'CA1234562', 2000, '03-JAN-20', 'yes', 'no', 'no', 'LO 1213')
;
insert into Loan_Application_Form values ('AA223353', 'CA1234563', 700, '15-JAN-20', 'yes', 'yes', 'no', 'LO 1214')
;
insert into Loan_Application_Form values ('AA223354', 'CA1234564', 500, '08-APR-20', 'yes', 'yes', 'yes', 'LO 1215')
;
insert into Loan_Application_Form values ('AA223355', 'CA1234565', 400, '17-SEP-20', 'yes', 'no', 'no', 'LO 1216')
;
insert into Loan_Application_Form values ('AA223356', 'CA1234566', 500, '01-OCT-20', 'yes', 'no', 'yes', 'LO 1217')
;
insert into Loan_Application_Form values ('AA223357', 'CA1234567', 1200, '29-OCT-20', 'yes', 'no', 'yes', 'LO 1218')
;
insert into Loan_Application_Form values ('AA223358', 'CA1234568', 2000, '30-JAN-21', 'yes', 'yes', 'yes', 'LO 1219')
;
insert into Loan_Application_Form values ('AA223359', 'CA1234569', 2000, '05-APR-21', 'no', 'yes', 'no', 'LO 1220')
;
select * from Loan_Application_Form
;

--5.Bank 
insert into Bank values ('BRC 001', 'Annual Report 2020', 'LoanGrant_2020', 50000, 0.23)
;
insert into Bank values ('BRC 002', 'Annual Report 2020', 'LoanGrant_2020', 50000, 0.19)
;
insert into Bank values ('BRC 003', 'Annual Report 2021', 'LoanGrant_2019', 45678, 0.45)
;
insert into Bank values ('BRC 004', 'Annual Report 2021', 'LoanGrant_2020', 102000, 0.15)
;
insert into Bank values ('BRC 005', 'Annual Report 2022', 'LoanGrant_2020', 670676, 0.10)
;
insert into Bank values ('BRC 006', 'Annual Report 2022', 'LoanGrant_2019', 50000, 0.2)
;
insert into Bank values ('BRC 007', 'Annual Report 2023', 'LoanGrant_2019', 220000, 0.22)
;
insert into Bank values ('BRC 008', 'Annual Report 2023', 'LoanGrant_2019', 100000, 0.17)
;
insert into Bank values ('BRC 009', 'Annual Report 2024', 'LoanGrant_2019', 67000, 0.20)
;
insert into Bank values ('BRC 010', 'Annual Report 2024', 'LoanGrant_2020', 67989, 0.13)
;
select * from Bank
;

--6. Loan Agents
insert into Loan_Agents values ('LA 001', 'BRC 001', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 002', 'BRC 002', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 003', 'BRC 003', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 004', 'BRC 004', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 005', 'BRC 005', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 006', 'BRC 006', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 007', 'BRC 007', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 008', 'BRC 008', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 009', 'BRC 009', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
insert into Loan_Agents values ('LA 010', 'BRC 010', 'Bank Teller', 'Customer relationship maintenance and loan options advice')
;
select * from Loan_Agents
;

--7. Type
insert into Type values (
'Term Loans', 5)
;
insert into Type values (
'SBA Loans', 3)
;
insert into Type values (
'Business lines of credit', 8)
;
insert into Type values (
'Equipment Loans', 3)
;
insert into Type values (
'Invoice Factoring and Invoice Financing', 9)
;
insert into Type values (
'Microloans', 2)
;
insert into Type values (
'Merchant Cash Advances', 2)
;
select * from Type
;

--Part four: report generation
/*1. Use sql queries to generate a table in which the number of loans processed, the total values of the loans, 
and the names of the regions in India are summarized.*/
select d.region, count(l.loan_id) "Loan Number", sum(l.amount) "Total Amount" from 
Loan l full outer join Loan_Application_Form la on l.loan_id = la.loan_id 
full outer join Candidate c on la.candidate_id = c.candidate_id
right join Demographic_Status d on c.status_type = d.status_type
--use right join because we care about region
group by d.region
order by 1
;

/*--2. For each type of status, summarize the average score, average value of loan approved, and average income of 
the client.*/
select  d.status_type, round(avg(l.score),2) "Average Credit Score", 
       round(avg(l.amount),2) "Average Loan Amount", round(avg(c.income),2) "Average Income"  from
loan l full outer join loan_application_form la on l.loan_id = la.loan_id
full outer join candidate c on la.candidate_id = c.candidate_id
right join demographic_status d on c.status_type = d.status_type
group by d.status_type
order by 1
;

/*–3. For each loan type, generate a table that summarizes the number of loans and the total value of the loans.
*/
select to_char(sum(l.amount), '$999,999.00') Total,
       sum(case when t.loan_type = 'Term Loans' then 1 else 0 end) TL,
       sum(case when t.loan_type = 'SBA Loans' then 1 else 0 end) SBA,
       sum(case when t.loan_type = 'Business lines of credit' then 1 else 0 end) BuC,
       sum(case when t.loan_type = 'Equipment Loans' then 1 else 0 end) EqL,
       sum(case when t.loan_type = 'Invoice Factoring and Invoice Financing' then 1 else 0 end) InF,
       sum(case when t.loan_type = 'Microloans' then 1 else 0 end) MicL,
       sum(case when t.loan_type = 'Merchant Cash Advances' then 1 else 0 end) MerCA
from loan l right join type t on l.loan_type = t.loan_type
;

/*–4. For each branch of our bank, generate a table summarizing the budget figures, the values of the loan approved, 
and whether the budget is effectively controlled: if loan approved > budget, NO. Otherwise, YES.*/
select b.branch_id, sum(b.budget_for_MFI) Budget, sum(l.amount) "Total Loan",
       case when sum(l.amount) > sum(b.budget_for_MFI) then 'NO' else 'YES' end "Budget Controlled?"
from loan l full join loan_application_form la on l.loan_id = la.loan_id
full join candidate c on la.candidate_id = c.candidate_id
full join loan_agents lg on c.loan_agent_id = lg.loan_agent_id
right join bank b on lg.branch_id = b.branch_id
group by b.branch_id
order by 1
;

/*--5. Generate a table that will check if those candidates have not either rent_morgage_info or proof_of_character 
are authorized. The table should show candidate_id, rent_mortgage_info, proof_of_character, and loan_id*/
select * from (
               select candidate_id, rent_mortgage_info, proof_of_character, loan_id 
               from loan_application_form 
               where rent_mortgage_info = 'no' and proof_of_character = 'no'
              )
where exists (select loan_id from loan)
;
