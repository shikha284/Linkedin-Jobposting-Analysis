DROP DATABASE IF EXISTS linkedin;
CREATE DATABASE linkedin;
USE linkedin;

CREATE TABLE IF NOT EXISTS companies (
    company_id      BIGINT  NOT NULL,
    name            TEXT    NOT NULL,
    description     TEXT    NULL,
    company_size    INT     NULL,
    address         TEXT    NULL,
    city            TEXT    NULL,
    state           TEXT    NULL,
    country         TEXT    NULL,
    zip_code        TEXT    NULL,
    url             TEXT    NULL,

    CONSTRAINT pk_c_company_id  PRIMARY KEY (company_id)
);

CREATE TABLE IF NOT EXISTS employee_counts (
    company_id      BIGINT      NOT NULL,
    time_recorded   DATETIME(6) NOT NULL,
    employee_count  BIGINT      NOT NULL,
    follower_count  BIGINT      NOT NULL,

    CONSTRAINT pk_ec            PRIMARY KEY (company_id, time_recorded, employee_count, follower_count),
    CONSTRAINT fk_ec_company_id FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS company_specialities (
    company_id      BIGINT          NOT NULL,
    speciality      VARCHAR(256)    NOT NULL,

    CONSTRAINT pk_cs            PRIMARY KEY (company_id, speciality),
    CONSTRAINT fk_cs_company_id FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS company_industries (
    company_id      BIGINT      NOT NULL,
    industry        VARCHAR(50) NOT NULL,

    CONSTRAINT pk_ci            PRIMARY KEY (company_id),
    CONSTRAINT fk_ci_company_id FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS job_postings (
    job_id                      BIGINT      NOT NULL,
    company_id                  BIGINT      NULL,

    title                       TEXT        NOT NULL,
    description                 TEXT        NULL,
    skills_desc                 TEXT        NULL,
    work_type                   TEXT        NULL,
    location                    TEXT        NULL,
    currency                    TEXT        NULL,
    remote_allowed              INT         NULL,
    sponsored                   INT         NULL,

    max_salary                  DOUBLE      NULL,
    med_salary                  DOUBLE      NULL,
    min_salary                  DOUBLE      NULL,
    pay_period                  TEXT        NULL,
    compensation_type           TEXT        NULL,

    formatted_work_type         TEXT        NULL,
    formatted_experience_level  TEXT        NULL,

    applies                     INT         NULL,
    views                       BIGINT      NULL,

    original_listed_time        DATETIME(6) NULL,
    listed_time                 DATETIME(6) NULL,
    expiry                      DATETIME(6) NULL,
    closed_time                 DATETIME(6) NULL,

    posting_domain              TEXT        NULL,
    job_posting_url             TEXT        NULL,
    application_url             TEXT        NULL,
    application_type            TEXT        NULL,

    CONSTRAINT pk_jp_job_id     PRIMARY KEY (job_id),
    CONSTRAINT fk_jp_company_id FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

CREATE TABLE IF NOT EXISTS job_skills (
    job_id          BIGINT      NOT NULL,
    skill_abr       VARCHAR(4)  NOT NULL,

    CONSTRAINT pk_js            PRIMARY KEY (job_id, skill_abr),
    CONSTRAINT fk_js_job_id     FOREIGN KEY (job_id) REFERENCES job_postings(job_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS job_industries (
    job_id          BIGINT  NOT NULL,
    industry_id     BIGINT  NOT NULL,

    CONSTRAINT pk_ji            PRIMARY KEY (job_id, industry_id),
    CONSTRAINT fk_ji_job_id     FOREIGN KEY (job_id) REFERENCES job_postings(job_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS benefits (
    job_id          BIGINT      NOT NULL,
    type            VARCHAR(30) NOT NULL,
    inferred        INT         NOT NULL,

    CONSTRAINT pk_b             PRIMARY KEY (job_id, type),
    CONSTRAINT fk_b_job_id      FOREIGN KEY (job_id) REFERENCES job_postings(job_id) ON DELETE CASCADE
);