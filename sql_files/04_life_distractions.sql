-- Compare average study hours based on prayer consistency
SELECT
  prayed_all_five,
  COUNT(*) AS total_days,
  ROUND(AVG(study_hours)::numeric, 2) AS avg_study_hours
FROM day_context_log dcl
JOIN daily_schedule_log dsl ON dcl.date = dsl.date
GROUP BY prayed_all_five
ORDER BY prayed_all_five DESC;

-- Q2: See if spending time with friends increases or decreases study time
SELECT
  spent_time_with_friends,
  COUNT(*) AS total_days,
  ROUND(AVG(study_hours)::numeric, 2) AS avg_study_hours
FROM day_context_log dcl
JOIN daily_schedule_log dsl ON dcl.date = dsl.date
GROUP BY spent_time_with_friends
ORDER BY avg_study_hours DESC;

-- Q3: Check how eating alone or with others impacts average study hours
SELECT
  ate_alone,
  COUNT(*) AS total_days,
  ROUND(AVG(study_hours)::numeric, 2) AS avg_study_hours
FROM day_context_log dcl
JOIN daily_schedule_log dsl ON dcl.date = dsl.date
GROUP BY ate_alone
ORDER BY avg_study_hours DESC;

-- Q4: Study time based on combinations of FIFA/cards and late scrolling
SELECT
  played_fifa_or_cards,
  watched_movies_or_scrolled_late,
  COUNT(*) AS total_days,
  ROUND(AVG(study_hours)::numeric, 2) AS avg_study_hours
FROM day_context_log dcl
JOIN daily_schedule_log dsl ON dcl.date = dsl.date
GROUP BY played_fifa_or_cards, watched_movies_or_scrolled_late
ORDER BY avg_study_hours DESC;

-- Q5: Find days with no distractions and high study hours (3+ hrs)
SELECT
  dsl.date,
  dsl.study_hours,
  dsl.main_focus,
  dcl.had_coffee,
  dcl.ate_alone,
  dcl.prayed_all_five,
  dcl.spent_time_with_friends
FROM daily_schedule_log dsl
JOIN day_context_log dcl ON dsl.date = dcl.date
WHERE dcl.played_fifa_or_cards = 'No'
  AND dcl.watched_movies_or_scrolled_late = 'No'
  AND dsl.study_hours >= 3
ORDER BY dsl.study_hours DESC;
