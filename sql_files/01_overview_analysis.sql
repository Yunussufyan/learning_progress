-- Question 1: Count how many days I studied vs. didn’t study
-- Clean up the 'studied' column using LOWER() + TRIM() to ensure consistency
-- Use CASE to rename values into readable labels

SELECT
  CASE
    WHEN LOWER(TRIM(studied)) = 'yes' THEN 'Days Studied'
    WHEN LOWER(TRIM(studied)) = 'no' THEN 'Days Not Studied'
    ELSE 'Unknown'
  END AS study_status,
  COUNT(*) AS total_days
FROM daily_schedule_log
GROUP BY study_status;

-- 2a: Average study hours across all days (PostgreSQL compatible)
SELECT
  ROUND(AVG(study_hours)::numeric, 2) AS avg_study_hours_overall
FROM daily_schedule_log;

-- 2b: Average study hours only on study days
SELECT
  ROUND(AVG(study_hours)::numeric, 2) AS avg_study_hours_when_studied
FROM daily_schedule_log
WHERE LOWER(TRIM(studied)) = 'yes';

-- Question 3: Find the top 5 days with the highest study hours
-- Only include days where study was actually done
-- Sort in descending order and limit to 5

SELECT
  date,
  study_hours,
  main_focus,
  notes
FROM daily_schedule_log
WHERE LOWER(TRIM(studied)) = 'yes'
ORDER BY study_hours DESC
LIMIT 5;

# Question 3b: Find the top 5 days with the lowest study hours
-- Only include days where study was actually done
SELECT
  date,
  study_hours,
  main_focus,
  notes
FROM daily_schedule_log
WHERE LOWER(TRIM(studied)) = 'yes'
ORDER BY study_hours 
LIMIT 5;

-- Question 4: Find the most common main_focus values during study days
-- We ignore non-study days (they have NULL main_focus)
-- Group and count each focus type

SELECT
  main_focus,
  COUNT(*) AS total_days_focused
FROM daily_schedule_log
WHERE LOWER(TRIM(studied)) = 'yes'
GROUP BY main_focus
ORDER BY total_days_focused DESC;

-- Question 5a: Count how many projects you've completed
SELECT
  COUNT(*) AS total_projects_done
FROM projects_done;

-- Question 5b: Count how many unique skills you've mastered
SELECT
  COUNT(*) AS total_skills_mastered
FROM skills_mastered;

-- Question 6: Group days into streaks of Yes/No study patterns
WITH ranked_days AS (
    SELECT
        date,
        studied,
        ROW_NUMBER() OVER (ORDER BY date) -
        ROW_NUMBER() OVER (PARTITION BY studied ORDER BY date) AS streak_id
    FROM daily_schedule_log
),

streaks AS (
    SELECT
        studied,
        MIN(date) AS streak_start,
        MAX(date) AS streak_end,
        COUNT(*) AS streak_length
    FROM ranked_days
    GROUP BY studied, streak_id
)

-- Final step: Get the top streak per category (Yes and No)
SELECT *
FROM streaks
WHERE (studied = 'Yes' AND streak_length = (
           SELECT MAX(streak_length) FROM streaks WHERE studied = 'Yes'))
   OR (studied = 'No' AND streak_length = (
           SELECT MAX(streak_length) FROM streaks WHERE studied = 'No'))
ORDER BY studied DESC;

