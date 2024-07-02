USE linkedin;
#1
SELECT j.company_id, c.name AS company_name, COUNT(*) AS job_posting_count, location, j.title, 
j.med_salary
FROM job_postings AS j 
JOIN companies AS c ON j.company_id = c.company_id
where j.med_salary != "NULL"
GROUP BY j.company_id, company_name, j.title, location, j.med_salary
ORDER BY COUNT(*) DESC 
LIMIT 10;

#2
SELECT  j.job_id,j.location, c.name, j.title, datediff(expiry,listed_time) as Days_to_apply
FROM job_postings_old AS j
JOIN companies AS c ON j.company_id = c.company_id
JOIN  benefits AS jben
ON j.job_id =  jben.job_id
where jben.inferred = 1
ORDER BY j.location, j.closed_time DESC, j.max_salary DESC;

#3
SELECT
    ci1.company_id AS company_id,
    ci2.company_id AS competitor_company_id,
    c1.name AS company_name,
    c2.name AS competitor_company_name,
    ci1.industry AS shared_industry
FROM company_industries AS ci1
JOIN company_industries AS ci2 ON ci1.industry = ci2.industry AND ci1.company_id < ci2.company_id
JOIN companies AS c1 ON ci1.company_id = c1.company_id
JOIN companies AS c2 ON ci2.company_id = c2.company_id;


#4
SELECT 
Month(expiry) AS month, SUM(views) AS total_views,
COUNT(*) AS job_count
FROM job_postings_old
GROUP BY month
ORDER BY month;

#stored1
DELIMITER //
CREATE PROCEDURE GetCompanieswithspecificBenefit(BenefitType VARCHAR(100))
BEGIN
  SELECT DISTINCT j.job_id, c.name AS company_name
    FROM job_postings AS j
	join companies as c on c.company_id = j.company_id
    JOIN benefits AS b ON j.job_id = b.job_id
    WHERE b.type = BenefitType;
END;
//
DELIMITER ;
call GetCompanieswithspecificBenefit('Vision insurance');

#stored 2
DELIMITER //
CREATE PROCEDURE CalculateEmployeeCountByIndustry()
BEGIN
    SELECT ci.industry, c.name, ec.employee_count
    FROM company_industries AS ci
    INNER JOIN companies AS c on ci.company_id =c.company_id
    INNER JOIN employee_counts AS ec ON ci.company_id = ec.company_id
    group by ci.industry, c.name,ec.employee_count ;

END;
//
DELIMITER ;
call CalculateEmployeeCountByIndustry();

#stored3
DELIMITER //
CREATE PROCEDURE GetJobPostingsWithMetricsAndSortByCompanySize(type_of_work VARCHAR(100))
BEGIN
   SELECT jp.job_id,c.name AS company_name, jp.title, jp.description, jp.pay_period,
           jp.work_type,
           c.company_size
           
    FROM job_postings AS jp
    INNER JOIN companies AS c ON jp.company_id = c.company_id
    where jp.work_type = type_of_work
    ORDER BY c.company_size desc;
END;
//
DELIMITER ;
call GetJobPostingsWithMetricsAndSortByCompanySize('PART_TIME');

#Trigger1
-- Create the job_postings_audit table to store audit records
CREATE TABLE job_postings_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    updated_column VARCHAR(50),
    old_value VARCHAR(50),
    new_value VARCHAR(50) );
-- Create the trigger to log changes to the job_postings table
DELIMITER //
CREATE TRIGGER JobPostingsAuditTrigger
AFTER UPDATE ON job_postings FOR EACH ROW
BEGIN
    INSERT INTO job_postings_audit (job_id, updated_column, old_value, new_value)
    VALUES (OLD.job_id, 'title', OLD.title, NEW.title);
    INSERT INTO job_postings_audit (job_id, updated_column, old_value, new_value)
    VALUES (OLD.job_id, 'work_type', OLD.work_type, NEW.work_type);
    INSERT INTO job_postings_audit (job_id, updated_column, old_value, new_value)
    VALUES (OLD.job_id, 'location', OLD.location, NEW.location);
END;
//
DELIMITER ;
UPDATE job_postings
SET title = 'Sales Manager', work_type ='FULL_TIME', location = 'Santa Clarita'
WHERE job_id = 133114754;
SELECT * FROM job_postings_audit;

#Trigger2
DELIMITER //
CREATE TRIGGER CascadeJobDeletion
BEFORE DELETE ON job_postings
FOR EACH ROW
BEGIN
    DELETE FROM job_industries WHERE job_id = OLD.job_id;
    DELETE FROM job_skills WHERE job_id = OLD.job_id;
END;
//
DELIMITER ;



