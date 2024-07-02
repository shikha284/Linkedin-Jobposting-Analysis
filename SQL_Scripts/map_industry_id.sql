SELECT DISTINCT ji.industry_id, ci.industry
FROM linkedin.job_postings as jp
    JOIN (
        SELECT company_id, COUNT(industry) as cii_count
        FROM linkedin.company_industries
        GROUP BY company_id
		HAVING cii_count = 1
    ) as ci_count ON jp.company_id = ci_count.company_id
    JOIN linkedin.company_industries as ci ON jp.company_id = ci.company_id
    JOIN (
        SELECT job_id, COUNT(industry_id) as jii_count
        FROM linkedin.job_industries
        GROUP BY job_id
		HAVING jii_count = 1
    ) as ji_count ON jp.job_id = ji_count.job_id
    JOIN linkedin.job_industries as ji ON jp.job_id = ji.job_id
WHERE jp.company_id IS NOT NULL
ORDER BY ji.industry_id;


