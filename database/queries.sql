
-- View all tasks
SELECT * FROM tasks;

-- Filter by priority
SELECT * FROM tasks WHERE priority = 'high';

-- Filter incomplete tasks
SELECT * FROM tasks WHERE done = false;

-- Search by title
SELECT * FROM tasks WHERE title ILIKE '%react%';

-- Sort and limit results
SELECT * FROM tasks ORDER BY created_at DESC LIMIT 3;

-- Count completed tasks
SELECT COUNT(*) FROM tasks WHERE done = true;

-- Group tasks by priority
SELECT priority, COUNT(*) AS total
FROM tasks
GROUP BY priority;

-- Update a task
UPDATE tasks SET done = true WHERE id = 3;

-- Delete a specific task
DELETE FROM tasks WHERE id = 5;

-- Invalid examples (uncomment to test errors)
-- INSERT INTO tasks (title, priority) VALUES ('Bad', 'urgent');
-- INSERT INTO tasks (priority) VALUES ('low');
