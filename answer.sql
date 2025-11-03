SELECT
    t1.investor_id,
    t3.sector_name,
    -- Calculate the share percentage: (sector_shares / total_investor_shares) * 100, rounded to two decimal places
    ROUND(
        (CAST(t1.no_of_shares AS REAL) * 100.0) / t2.total_shares,
        2
    ) AS share_percentage
FROM
    investor_transactions AS t1
JOIN
    -- Subquery (or CTE) to calculate the total number of shares for each investor
    (
        SELECT
            investor_id,
            SUM(no_of_shares) AS total_shares
        FROM
            investor_transactions
        GROUP BY
            investor_id
    ) AS t2
ON
    t1.investor_id = t2.investor_id
JOIN
    sectors AS t3
ON
    t1.sector_id = t3.sector_id
ORDER BY
    t1.investor_id,
    share_percentage DESC;
