SELECT *
FROM linkedin.job_postings
WHERE job_id NOT IN (
        SELECT job_id
        FROM linkedin.job_postings
        WHERE closed_time < CURRENT_TIMESTAMP()
            OR expiry < CURRENT_TIMESTAMP()
    );