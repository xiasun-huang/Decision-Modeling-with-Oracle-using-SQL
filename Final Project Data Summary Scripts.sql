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
date_of_birth   date,
income          number,
business_name   varchar(20),
loan_agent_id   varchar(20),
state           varchar(50)
)
;

--2. Demographic Status
create table Demographic_Status (
state                  varchar(50),
average_income         number,
population             varchar(50),
gender_ratio           number,
region                 varchar(50)
)
;

--3. Loan
create table Loan (
loan_id       varchar(20),
loan_type     varchar(50),
amount        number,
loan_interest number,
score         number,
loan_status   varchar(20)
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
revenue_y0              number,
revenue_y1              number,
loan_ID                 varchar(20)
)
;
    
--5.Bank
create table Bank(
branch_id                    varchar(20),
base                         varchar(50),
data_report                  varchar(20),
decision_rendering_algorithm varchar(20),
budget_for_MFI               number,
manager_name                 varchar(50)
)
;

--6. Loan Agents
create table Loan_Agents (
loan_agent_id     varchar(20),
branch_id         varchar(20),
title             varchar(20),
service_specialty varchar(100)
)
;

--7. Type
create table Type (
loan_type        varchar(10),
discription      varchar(50),
term_limit       varchar(20),
maximum_amount   number,
application_requirement  varchar(100)
)
;

--Part two alter the table with primary keys anf foreign keys
--1. Loan Agents
alter table Loan_Agents
add constraint loan_agents_pk1 primary key(loan_agent_id)
;

--2. Demographic Staus
alter table Demographic_Status
add constraint demographic_status_pk1 primary key(state)
;

--3. Candidate
alter table Candidate
add constraint candidate_pk1 primary key(candidate_id) 
add constraint candidate_fk1 foreign key(loan_agent_id) references Loan_Agents(loan_agent_id)
add constraint candidate_fk2 foreign key(state) references Demographic_Status(state)
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

alter table candidate
modify candidate_name varchar(50)
;

--Part three: import data from the csv files and export views of the tables
--All csv files: --Bank
                 --Candidate
                 --Demographic Features
                 --Loan Agents
                 --Loan
                 --Loan_Applicaition_Form
                 --Type
select * from candidate
;
select * from loan_application_form
;
select * from loan
;
select * from type
;
select * from demographic_status
;
select * from loan_agents
;
select * from bank
;

--Part four: use queries to summarize how we would improve loan approval rate
--1. Approval Rate Improvement by Region
/*In this section, generate a clean table to eveluate our performance in approving loans
in different markets in India. This provides a good picture of how the number of approval 
can be increased when the new policy replaces the old one*/
select 'New Policy' "Policy", sum(high_income) + sum(low_income_good_records) + sum(bad_records_but_growth) Total,
--Step two: summarize number of candidates approved by Region
       sum(case when region = 'Central India' then high_income + low_income_good_records + bad_records_but_growth 
           else 0 end) "Central India",
       sum(case when region = 'Eastern India' then high_income + low_income_good_records + bad_records_but_growth 
           else 0 end) "Eastern India",
       sum(case when region = 'Northeastern India' then high_income + low_income_good_records + bad_records_but_growth 
           else 0 end) "Northeastern India",
       sum(case when region = 'Northern India' then high_income + low_income_good_records + bad_records_but_growth 
           else 0 end) "Northern India",
       sum(case when region = 'Southern India' then high_income + low_income_good_records + bad_records_but_growth 
           else 0 end) "Southern India",
       sum(case when region = 'Western India' then high_income + low_income_good_records + bad_records_but_growth 
           else 0 end) "Western India"
from (
  select region, 
/*Step one: count the number of candidates that can be approved for each stratification, which is divided based on the 
bank's different loan approval criteria:
   --those meet income criterion: income statement with balance over $900
   --those meet minimum creditworthiness requirements: credit records in terms of phone connection records, 
     rent & mortgage informaiton, and proof of character
   --those can prove revenue growth in their small businesses: most recent revenue growth
*/
       case when income >= 900 then 1 else 0 end high_income,
       case when income < 900 and phone_connection_info = 'yes' and rent_mortgage_info = 'yes' and 
           proof_of_character = 'yes' then 1 else 0 end low_income_good_records,
       case when income < 900 and rent_mortgage_info = 'no' and proof_of_character = 'no' and 
           revenue_y1 - revenue_y0 > 0 then 1 else 0 end bad_records_but_growth
  from
  loan l full outer join loan_application_form fo on l.loan_id = fo.loan_id
  full outer join candidate c on fo.candidate_id = c.candidate_id
  full outer join demographic_status d on c.state = d.state
)
UNION
--Step three: combine the two reports under the two different policies
select 
       'Old Policy' "Policy", sum(high_income) Total,
       sum(case when region = 'Central India' then high_income else 0 end) "Central India",
       sum(case when region = 'Eastern India' then high_income else 0 end) "Eastern India",
       sum(case when region = 'Northeastern India' then high_income else 0 end) "Northeastern India",
       sum(case when region = 'Northern India' then high_income else 0 end) "Northern India",
       sum(case when region = 'Southern India' then high_income else 0 end) "Southern India",
       sum(case when region = 'Western India' then high_income else 0 end) "Western India"
from (
  select region, 
       case when income >= 900 then 1 else 0 end high_income
  from
  loan l full outer join loan_application_form fo on l.loan_id = fo.loan_id
  full outer join candidate c on fo.candidate_id = c.candidate_id
  full outer join demographic_status d on c.state = d.state
)
;

--2. Recommended Types of Loans & Loan Availablity Structure Optimization
--Current Authorized Loan Structure
/*the most popular loans are INVF and MICRO*/
/*we recommend MICRO and MERA to our applicants since they are much more flexible. Given that MERA charges 5% 
of revenue as interests, we recommend MERA for women with business revenue no higher than the maximum amount for
this kind of loan, $5,000.*/
/*for women who do not meet any criteria for a loan approval, we recommend BUSC for which women can join small 
business partnerships*/
select count(loan_type) Total, sum(case when loan_type = 'TL' then 1 else 0 end) TL,
       sum(case when loan_type = 'SBA' then 1 else 0 end) SBA,
       sum(case when loan_type = 'BUSC' then 1 else 0 end) BUSC,
       sum(case when loan_type = 'EL' then 1 else 0 end) EL,
       sum(case when loan_type = 'INVF' then 1 else 0 end) INVF,
       sum(case when loan_type = 'MICRO' then 1 else 0 end) MICRO,
       sum(case when loan_type = 'MERA' then 1 else 0 end) MERA
from (
select t.loan_type, l.loan_id from
loan l right outer join type t on l.loan_type = t.loan_type
)
;