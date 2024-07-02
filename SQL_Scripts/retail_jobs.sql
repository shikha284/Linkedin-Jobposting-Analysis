DELIMITER //
CREATE PROCEDURE
GET_JOB_FROM_INDUSTRY(
    IN industry name VARCHAR(30)
)
BEGIN
    SELECT jp.job id, jp.company id, jp.title, jp.work_type,
        jp.location, jp.expiry, jp.closed_time, jp.posting_domain,
        jp.job_posting_url, jp.application_url
    FROM linkedin.job postings AS jp
    JOIN linkedin.company industries AS ci
        ON jp.company id = ci.company id
    WHERE ci.industry = industry name;
END //
DELIMITER ;

CALL GET JOB FROM INDUSTRY('Retail');