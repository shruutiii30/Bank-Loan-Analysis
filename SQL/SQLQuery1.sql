-- Total Loan Application --
select count(id) as Total_Loan_Applications from bank_loan_data

-- Month to Date Loan Apllications --
select count(id) as MTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 12 and year(issue_date) = 2021

-- Previous Month to Date Loan Applications --
select count(id) as PMTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 11 and year(issue_date) = 2021

-- Total Funded Amount --
select sum(loan_amount) as Total_Funded_Amount 
from bank_loan_data

-- Total Funded Amount (Month-To-Date) --
select sum(loan_amount) as MTD_Total_Funded_Amount 
from bank_loan_data
where MONTH(issue_date) = 12 and year(issue_date)= 2021

-- Total Funded Amount (Previous Month-To-Date) --
select sum(loan_amount) as PMTD_Total_Funded_Amount 
from bank_loan_data
where MONTH(issue_date) = 11 and year(issue_date)= 2021

-- Total Amount Received --
select sum(total_payment) as Total_Amount_Recieved from bank_loan_data

-- Total Amount Received (Month-To-Date) --
select sum(total_payment) as MTD_Total_Amount_Recieved from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

-- Total Amount Received (Previous Month-To-Date) --
select sum(total_payment) as PMTD_Total_Amount_Recieved from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

-- Average Interest Rate --
select round(avg(int_rate), 4) * 100 as Average_Interest_Date
from bank_loan_data

-- Average Interest Rate (Month-To-Date) --
select round(avg(int_rate), 4) * 100 as MTD_Average_Interest_Date
from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

-- Average Interest Rate (Previous Month-To-Date) --
select round(avg(int_rate), 4) * 100 as PMTD_Average_Interest_Date
from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

-- Average Debt-To-Income Ratio (DTI) --
select round(avg(dti), 4) * 100 Avg_DTI
from bank_loan_data

-- DTI (Month-To-Date) --
select round(avg(dti), 4) * 100 MTD_Avg_DTI
from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

-- DTI (Previous Month-To-Date) --
select round(avg(dti), 4) * 100 PMTD_Avg_DTI
from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

-- Good Loan Application Percentage --
select
	(count(case when loan_status= 'Fully Paid' or loan_status= 'Current' then id end)*100)
	/
	count(id) as Good_loan_Percentage
from bank_loan_data

-- Good Loan Applications --
select count(id) as Good_Loan_Applications 
from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current'

-- Good Loan Funded Amount --
select sum(loan_amount) as Good_Loan_Funded_Amount
from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current'

-- Good Loan Total Received Amount --
select sum(total_payment) as Good_Loan_Total_Payment_Recieved
from bank_loan_data
where loan_status='Fully Paid' or loan_status='Current'

-- Bad Loan Percentage --
select 
	(count(case when loan_status='Charged Off' then id end) * 100.0) /
		count(id) as Bad_Loan_Percentage
from bank_loan_data

-- Bad Loan Applications --
select count(id) as Bad_Loan_applications
from bank_loan_data
where loan_status='Charged Off'

-- Bad Loan Funded Amount --
select sum(loan_amount) as Bad_Loan_Funded_Amount
from bank_loan_data
where loan_status='Charged Off'

-- Bad Loan Amount Received --
select sum(total_payment) as Bad_Loan_Amount_Recieved
from bank_loan_data
where loan_status='Charged Off'

-- Loan Status Grid View --
select
	loan_status,
	count(id) as Total_Loan_Applications,
	sum(total_payment) as Total_Amount_Recieved,
	sum(loan_amount) as Total_Funded_Amount,
	avg(int_rate*100) as Interest_Rate,
	avg(dti*100) as DTI
from
	bank_loan_data
group by
	loan_status

select
	loan_status,
	sum(total_payment) as MTD_Total_Amount_Recieved,
	sum(loan_amount) as MTD_Total_Funded_Amount
from bank_loan_data
where MONTH(issue_date)=12
group by loan_status

select
	home_ownership,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by home_ownership
order by count(id) desc
