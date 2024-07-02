USE linkedin;
SET GLOBAL local_infile=1;

LOAD DATA LOCAL INFILE "give absolute path to cleaned companies.csv here"
INTO TABLE companies
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned company_industries.csv here"
INTO TABLE company_industries
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned company_specialities.csv here"
INTO TABLE company_specialities
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned employee_counts.csv here"
INTO TABLE employee_counts
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned job_postings.csv here"
INTO TABLE job_postings
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned job_industries.csv here"
INTO TABLE job_industries
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned job_skills.csv here"
INTO TABLE job_skills
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "give absolute path to cleaned benefits.csv here"
INTO TABLE benefits
COLUMNS
    TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    ESCAPED BY '\\'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES;