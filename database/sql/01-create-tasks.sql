-- =============================================
-- Part 2: Create the tasks table and add data
-- Run this file on the task_tracker database
-- =============================================

-- Start clean, so this file can be run again at any time
DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks (
  id          SERIAL PRIMARY KEY,
  title       VARCHAR(200) NOT NULL,
  priority    VARCHAR(10)  NOT NULL DEFAULT 'medium'
              CHECK (priority IN ('low', 'medium', 'high')),
  done        BOOLEAN      NOT NULL DEFAULT false,
  due_date    DATE,                                   -- optional
  created_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- 9 tasks with all their values
-- 3 high, 4 medium, 2 low | 3 done | 2 with "React" | 2 with no due date
INSERT INTO tasks (title, priority, done, due_date) VALUES
  ('Finish Git final task',        'high',   true,  '2026-11-03'),
  ('Install PostgreSQL',           'high',   false, '2026-11-04'),
  ('Fix React form validation',    'high',   false, NULL),
  ('Learn React useState',         'medium', true,  '2026-11-06'),
  ('Write SQL queries',            'medium', false, '2026-11-05'),
  ('Draw the database diagram',    'medium', false, '2026-11-09'),
  ('Read normalization article',   'medium', true,  NULL),
  ('Clean up old repos',           'low',    false, '2026-11-20'),
  ('Update GitHub profile',        'low',    false, '2026-11-30');

-- 10th task: only a title, so the defaults are used
-- (priority = 'medium', done = false, due_date = NULL, created_at = now)
INSERT INTO tasks (title) VALUES ('Plan Week 5 backend work');

-- Check the result
SELECT * FROM tasks;


-- ---------------------------------------------
-- Inserts that SHOULD fail (kept as comments)
-- ---------------------------------------------

-- 1) Breaks the priority rule
-- INSERT INTO tasks (title, priority) VALUES ('Urgent bug', 'urgent');
-- ERROR:  new row for relation "tasks" violates check constraint "tasks_priority_check"
-- DETAIL:  Failing row contains (11, Urgent bug, urgent, f, null, ...).

-- 2) No title
-- INSERT INTO tasks (priority) VALUES ('low');
-- ERROR:  null value in column "title" of relation "tasks" violates not-null constraint
-- DETAIL:  Failing row contains (12, null, low, f, null, ...).
