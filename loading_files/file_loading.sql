-- Load data into courses_taken from the server's data folder
COPY courses_taken
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/courses_taken_clean_FIXED.csv'
DELIMITER ','
CSV HEADER;

-- Load motivation tracker data from server directory
COPY motivation_tracker
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/motivation_tracker.csv'
DELIMITER ','
CSV HEADER;

-- Load data from daily_schedule_log CSV into PostgreSQL
COPY daily_schedule_log
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/daily_schedule_logs.csv'
DELIMITER ','
CSV HEADER;

-- Load the cleaned day context log into PostgreSQL
COPY day_context_log
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/day_context_logs.csv'
DELIMITER ','
CSV HEADER;

-- Load skill mastery data from CSV
COPY skills_mastered
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/skills_mastered.csv'
DELIMITER ','
CSV HEADER;

-- Import your clean practice sessions into PostgreSQL
COPY practice_sessions
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/practice_sessionss.csv'
DELIMITER ','
CSV HEADER;
select * from practice_sessions;

-- Import the project records into PostgreSQL
COPY projects_done
FROM 'C:/Program Files/PostgreSQL/17/data/csv_files/projects_dones.csv'
DELIMITER ','
CSV HEADER;
