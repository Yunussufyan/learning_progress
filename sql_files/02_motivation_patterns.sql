-- Question 1: Relationship between motivation levels and study hours
-- Join daily study log with motivation tracker by date
-- Get mood, energy, and actual study hours side by side

SELECT
  m.date,
  m.mood_level,
  m.energy_level,
  d.study_hours
FROM motivation_tracker m
JOIN daily_schedule_log d ON m.date = d.date
WHERE d.study_hours IS NOT NULL  -- Only include days with actual study time
ORDER BY d.study_hours DESC;  -- Order by study hours for better analysis

-- Question 2: Compare mood and energy levels on days I studied vs. didn't
-- This shows averages for both cases, grouped by 'studied' status

SELECT
  d.studied,
  ROUND(AVG(m.mood_level)::numeric, 2) AS avg_mood_level,
  ROUND(AVG(m.energy_level)::numeric, 2) AS avg_energy_level
FROM daily_schedule_log d
JOIN motivation_tracker m ON d.date = m.date
GROUP BY d.studied
ORDER BY d.studied DESC;

-- Question 3: Compare average study hours on days with vs. without distractions
-- We check for FIFA, movies/scrolling, and time with friends
-- All data comes from day_context_log joined with daily_schedule_log

SELECT
  dcl.played_fifa_or_cards,
  dcl.watched_movies_or_scrolled_late,
  dcl.spent_time_with_friends,
  ROUND(AVG(dsl.study_hours)::numeric, 2) AS avg_study_hours
FROM day_context_log dcl
JOIN daily_schedule_log dsl ON dcl.date = dsl.date
GROUP BY
  dcl.played_fifa_or_cards,
  dcl.watched_movies_or_scrolled_late,
  dcl.spent_time_with_friends
ORDER BY avg_study_hours DESC;

-- Question 4: Look at top study days and their day context
-- Join study + context, filter for highly productive days (3+ hours)

SELECT
  dsl.date,
  dsl.study_hours,
  dcl.had_coffee,
  dcl.ate_alone,
  dcl.prayed_all_five,
  dcl.spent_time_with_friends,
  dcl.played_fifa_or_cards,
  dcl.watched_movies_or_scrolled_late
FROM daily_schedule_log dsl
JOIN day_context_log dcl ON dsl.date = dcl.date
WHERE dsl.study_hours >= 3
ORDER BY dsl.study_hours DESC;

