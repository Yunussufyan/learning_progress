-- Count how many practice sessions per topic
SELECT
  topic,
  COUNT(*) AS total_sessions
FROM practice_sessions
GROUP BY topic
ORDER BY total_sessions DESC;

-- Total practice sessions by platform
SELECT
  platform,
  COUNT(*) AS total_sessions
FROM practice_sessions
GROUP BY platform
ORDER BY total_sessions DESC;

-- Total practice sessions by location
SELECT
  location,
  COUNT(*) AS total_sessions
FROM practice_sessions
GROUP BY location
ORDER BY total_sessions DESC;

-- Question 3: How much time did I spend on each topic by difficulty level?
-- This groups practice sessions by topic and difficulty
-- We get session count, average duration, and max duration

SELECT
  topic,
  difficulty_level,
  COUNT(*) AS total_sessions,
  ROUND(AVG(duration_minutes)::numeric, 2) AS avg_duration_minutes,
  MAX(duration_minutes) AS max_duration_minutes
FROM practice_sessions
GROUP BY topic, difficulty_level
ORDER BY total_sessions DESC, topic;

-- Question 4: See if session reflections correlate with time spent
-- Group sessions by the 'reflection' notes
-- Calculate average and max duration per reflection type

SELECT
  reflection,
  COUNT(*) AS total_sessions,
  ROUND(AVG(duration_minutes)::numeric, 2) AS avg_duration_minutes,
  MAX(duration_minutes) AS max_duration_minutes
FROM practice_sessions
GROUP BY reflection
ORDER BY avg_duration_minutes DESC;
