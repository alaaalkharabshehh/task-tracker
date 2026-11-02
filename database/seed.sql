
-- Insert sample tasks
INSERT INTO tasks (title, priority)
VALUES ('Finish Git task', 'high');

INSERT INTO tasks (title, priority, done) VALUES
    ('Learn useState', 'medium', true),
    ('Read React docs', 'low', false),
    ('Install PostgreSQL', 'high', false);

INSERT INTO tasks (title)
VALUES ('Default priority test');
