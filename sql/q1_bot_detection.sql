CREATE TABLE IF NOT EXISTS registration_times (
    CustomerId BIGINT,
    StepId INT,
    StartTime TIMESTAMP
);

WITH step_durations AS (
  SELECT
    CustomerId,
    StepId,
    StartTime,
    LEAD(StartTime) OVER (PARTITION BY CustomerId ORDER BY StepId) AS Next_step_time
  FROM registration_times
),

time_gap AS (
  SELECT
    CustomerId,
	EXTRACT(EPOCH FROM (Next_step_time - StartTime)) AS time_diff_sec
	FROM step_durations
	WHERE next_step_time IS NOT NULL
),

user_summary as ( 
  SELECT
    CustomerId,
    AVG(time_diff_sec) AS avg_time,
    MIN(time_diff_sec) AS min_step,
    MAX(time_diff_sec) AS max_step,
    STDDEV_POP(time_diff_sec) AS stddev_step,
    COUNT(*) AS steps_tracked
  FROM  time_gap
  GROUP BY CustomerId)

SELECT *,
CASE WHEN avg_time<23 THEN 1 ELSE 0 END AS suspected_bot
FROM user_summary
ORDER BY avg_time
