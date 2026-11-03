-- =============================================
-- Bonus: the full 5-table design in PostgreSQL
-- (the same design as design/schema.dbml)
-- Run on a fresh database, or it drops the old tables first
-- =============================================

DROP TABLE IF EXISTS task_tags, tags, tasks, projects, users;

CREATE TABLE users (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  email       VARCHAR(150) NOT NULL UNIQUE,
  created_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE projects (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  created_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE tasks (
  id          SERIAL PRIMARY KEY,
  title       VARCHAR(200) NOT NULL,
  priority    VARCHAR(10)  NOT NULL DEFAULT 'medium'
              CHECK (priority IN ('low', 'medium', 'high')),
  done        BOOLEAN      NOT NULL DEFAULT false,
  due_date    DATE,
  user_id     INTEGER      NOT NULL REFERENCES users(id),
  project_id  INTEGER      NOT NULL REFERENCES projects(id),
  created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
  -- Bonus: a due date can't be before the day the task was created
  CHECK (due_date >= created_at::date)
);

CREATE TABLE tags (
  id    SERIAL PRIMARY KEY,
  name  VARCHAR(50) NOT NULL UNIQUE
);

-- Many-to-many: one task has many tags, one tag is on many tasks
CREATE TABLE task_tags (
  task_id  INTEGER NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  tag_id   INTEGER NOT NULL REFERENCES tags(id)  ON DELETE CASCADE,
  PRIMARY KEY (task_id, tag_id)
);

-- Sample data: the bad table from Part 4, now normalized
INSERT INTO users (name, email) VALUES
  ('Tala', 'tala@example.com'),
  ('Alaa', 'alaa@example.com');

INSERT INTO projects (name) VALUES ('Trainee Program');

INSERT INTO tasks (title, priority, done, user_id, project_id) VALUES
  ('Finish Git task',    'high',   true,  1, 1),
  ('Learn useState',     'medium', false, 1, 1),
  ('Read React docs',    'low',    false, 2, 1),
  ('Install PostgreSQL', 'high',   false, 2, 1);

INSERT INTO tags (name) VALUES ('git'), ('urgent'), ('react'), ('reading'), ('database');

INSERT INTO task_tags (task_id, tag_id) VALUES
  (1, 1), (1, 2),
  (2, 3),
  (3, 3), (3, 4),
  (4, 5), (4, 2);

-- Preview of Wednesday: all tasks tagged "urgent", with the user's name
SELECT t.title, u.name AS user_name
FROM tasks t
JOIN users u      ON u.id = t.user_id
JOIN task_tags tt ON tt.task_id = t.id
JOIN tags g       ON g.id = tt.tag_id
WHERE g.name = 'urgent';
