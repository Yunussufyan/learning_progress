-- SQL script to create all tables for the learning_progress project
-- Each table reflects a different part of the user's learning journey



-- Creating the table to store all courses taken
-- Includes course details, platform, date range, hours spent, and completion status
CREATE TABLE courses_taken (
    course_name TEXT,         -- Name of the course (e.g., "Introduction to SQL")
    platform TEXT,            -- Platform used (e.g., DataCamp, LearnSQL.com)
    category TEXT,            -- Subject area (e.g., SQL, Excel, Power BI)
    start_date DATE,          -- When the course was started
    end_date DATE,            -- When the course was completed
    hours_spent INT,          -- Time spent on the course, in hours
    completed TEXT            -- Whether the course was completed ("Yes"/"No")
);

-- Table for tracking daily motivation and distractions
CREATE TABLE motivation_tracker (
    date DATE,                                  -- Date of the log entry
    mood_level INT,                             -- Mood score (1 to 10)
    energy_level INT,                           -- Energy score (1 to 10)
    social_distraction_minutes INT,             -- Minutes lost to socializing or scrolling
    notes TEXT                                   -- Freeform notes (optional)
);

-- Table logging daily study status and habits
CREATE TABLE daily_schedule_log (
    date DATE,                           -- The date being logged
    studied TEXT,                        -- Whether study happened ('Yes' or 'No')
    study_hours FLOAT,                  -- Total hours studied
    main_focus TEXT,                     -- Main topic/subject studied
    notes TEXT,                          -- Optional notes about the day
    reason_for_no_study TEXT             -- Reason for skipping study (if applicable)
);

-- Table logging contextual influences on each day
CREATE TABLE day_context_log (
    date DATE,                                 -- Date of the log
    had_coffee TEXT,                           -- Whether coffee was consumed
    ate_alone TEXT,                            -- Whether meals were eaten alone
    spent_time_with_friends TEXT,              -- Social interaction
    prayed_all_five TEXT,                      -- Prayer consistency (all 5 daily)
    played_fifa_or_cards TEXT,                 -- Evening distractions
    watched_movies_or_scrolled_late TEXT,      -- Late-night distractions
    notes TEXT                                  -- Summary or reflection notes
);

-- Table for tracking skills you’ve mastered and your confidence in them
CREATE TABLE skills_mastered (
    skill_name TEXT,             -- The name of the skill (e.g., Filtering, JOINs)
    category TEXT,               -- The skill category (e.g., SQL, Excel)
    confidence_level INT,        -- Your self-rated confidence (1–10)
    date_mastered DATE           -- When you considered the skill mastered
);

-- Table logging all practice sessions by topic, platform, and time
CREATE TABLE practice_sessions (
    date DATE,                      -- Date of the session
    topic TEXT,                     -- Topic practiced (e.g., Subqueries)
    platform TEXT,                  -- Platform used (ChatGPT, HackerRank, etc.)
    num_questions INT,              -- Number of questions attempted
    location TEXT,                  -- Where the session happened (e.g., Bed, Dorm)
    difficulty_level TEXT,          -- Difficulty (Easy, Medium, Hard)
    duration_minutes INT,           -- Duration in minutes
    reflection TEXT                 -- Personal notes/reflections on the session
);

-- Table of completed projects with tools, time, and platform
CREATE TABLE projects_done (
    project_title TEXT,         -- Title of the project
    tools_used TEXT,            -- Tools used (e.g., SQL, Excel, ChatGPT)
    duration_days INT,          -- Number of days it took to complete
    platform TEXT,              -- Platform where project was done or shared
    used_chatgpt TEXT           -- Whether ChatGPT was used in the project
);

