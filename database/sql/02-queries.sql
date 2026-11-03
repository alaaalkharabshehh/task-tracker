-- =============================================
-- Part 3: Queries on the tasks table
-- Run 01-create-tasks.sql first
-- =============================================

-- 1. All tasks, newest first
--    (rows inserted together get the same created_at, so id breaks the tie)
SELECT * FROM tasks
ORDER BY created_at DESC, id DESC;

-- 2. Only the title and priority of every task
SELECT title, priority FROM tasks;

-- 3. All high priority tasks
SELECT * FROM tasks
WHERE priority = 'high';

-- 4. All tasks that are not done (the "Active" filter in the React app)
SELECT * FROM tasks
WHERE done = false;

-- 5. Tasks that are not done and are high priority
SELECT * FROM tasks
WHERE done = false AND priority = 'high';

-- 6. Tasks with "react" in the title, in any upper or lower case
SELECT * FROM tasks
WHERE title ILIKE '%react%';

-- 7. Tasks that have no due date
--    (= NULL never matches anything; NULL means "unknown", so we use IS NULL)
SELECT * FROM tasks
WHERE due_date IS NULL;

-- 8. The 3 tasks with the nearest due date
--    (skip tasks with no due date, otherwise they could appear in the result)
SELECT * FROM tasks
WHERE due_date IS NOT NULL
ORDER BY due_date ASC
LIMIT 3;

-- 9. How many tasks are done? (one number)
SELECT COUNT(*) AS done_tasks FROM tasks
WHERE done = true;

-- 10. How many tasks there are for each priority
SELECT priority, COUNT(*) AS total
FROM tasks
GROUP BY priority
ORDER BY total DESC;

-- 11. Mark one task as done using its id
UPDATE tasks
SET done = true
WHERE id = 2;

-- 12. Change all low tasks that are not done to medium
UPDATE tasks
SET priority = 'medium'
WHERE priority = 'low' AND done = false;

-- 13. Delete one task using its id
--     First check which row will be deleted, using the same WHERE:
SELECT * FROM tasks
WHERE id = 8;

--     Then delete it:
DELETE FROM tasks
WHERE id = 8;
