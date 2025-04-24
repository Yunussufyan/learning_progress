-- Q1: Most time-intensive courses
SELECT
  course_name,
  platform,
  hours_spent
FROM courses_taken
ORDER BY hours_spent DESC;

-- Q2: Calculate time to mastery for each skill
WITH first_practice AS (
  SELECT
    LOWER(TRIM(topic)) AS skill_name,
    MIN(date) AS first_practice_date
  FROM practice_sessions
  GROUP BY LOWER(TRIM(topic))
),

study_days AS (
  SELECT
    ps.topic,
    ps.date,
    ds.study_hours
  FROM practice_sessions ps
  JOIN daily_schedule_log ds ON ps.date = ds.date
  WHERE ds.study_hours > 0
),

study_to_master AS (
  SELECT
    sm.skill_name,
    sm.date_mastered,
    COUNT(DISTINCT sd.date) AS study_days_to_master,
    sm.confidence_level
  FROM skills_mastered sm
  JOIN study_days sd ON LOWER(TRIM(sm.skill_name)) = LOWER(TRIM(sd.topic))
  WHERE sd.date <= sm.date_mastered
  GROUP BY sm.skill_name, sm.date_mastered, sm.confidence_level
)

SELECT *
FROM study_to_master
ORDER BY study_days_to_master DESC;

-- This SQL query provides an overview of projects and their characteristics.
-- It retrieves the project title, tools used, duration in days, platform, and whether ChatGPT was used.
-- The results are ordered by the project duration in descending order, showing the longest projects first.
-- Q3: Overview of projects and their characteristics
SELECT
  project_title,
  tools_used,
  duration_days,
  platform,
  used_chatgpt
FROM projects_done
ORDER BY duration_days DESC;


-- This query analyzes the tools used in various projects by breaking down a concatenated list of tools,
-- counting their occurrences, and displaying the results in descending order of usage frequency.

SELECT
  LOWER(TRIM(tool)) AS tool,
  COUNT(*) AS times_used
FROM (
  SELECT UNNEST(STRING_TO_ARRAY(tools_used, '+')) AS tool
  FROM projects_done
) t
GROUP BY LOWER(TRIM(tool))
ORDER BY times_used DESC;

