# Part 4: Normalization

## The starting table

| task_id | title | priority | done | user_name | user_email | tags |
|---|---|---|---|---|---|---|
| 1 | Finish Git task | high | true | Tala | tala@example.com | git, urgent |
| 2 | Learn useState | medium | false | Tala | tala@example.com | react |
| 3 | Read React docs | low | false | Alaa | alaa@example.com | react, reading |
| 4 | Install PostgreSQL | high | false | Alaa | alaa@example.com | database, urgent |

## 1. Which column breaks 1NF? Why?

The **`tags`** column. 1NF says every cell must hold **one single value**. Here one cell holds a list (`git, urgent`), so the database can't treat each tag as its own value: it can't check it, index it or join on it.

## 2. Which columns are repeated and break 3NF? What do they really depend on?

**`user_name`** and **`user_email`**. They are repeated on every task of the same user ("Tala, tala@example.com" appears twice).

They don't depend on the task (`task_id`). They depend on **the user**. A column that depends on another non-key column instead of the primary key breaks 3NF. The user's details belong in their own `users` table.

## 3. Tala changes her email. How many rows must be updated? What if one is missed?

**2 rows** (tasks 1 and 2), and with more tasks it would be more rows.

If one row is missed, the database holds **two different emails for the same person**, and nobody knows which one is correct. This is called an **update anomaly**.

## 4. Alaa deletes her only task. What information about Alaa is lost?

If Alaa had only one task and deleted it, **her name and email disappear from the database completely**, because they were only stored inside her task row. The database forgets she exists. This is called a **delete anomaly**.

(In the same way, we can't add a new user who has no tasks yet. That's an **insert anomaly**.)

## 5. How would you find all tasks with the tag "urgent"? Why is that hard?

We would have to search inside the text, for example:

```sql
SELECT * FROM tasks WHERE tags ILIKE '%urgent%';
```

This is slow and unreliable:
- It also matches tags like `not-urgent` or `urgently`.
- A spelling difference (`Urgent `, `urgent,`) can break it.
- The database can't use an index for it, and we can't count tasks per tag easily.

## 6. The design split into tables (3NF)

We need **4 tables**. A task belongs to one user, and the link between tasks and tags is **many-to-many** (one task has many tags, one tag is on many tasks), so it needs a linking table.

### `users`
| Column | Notes |
|---|---|
| **id** | Primary key |
| name | |
| email | Unique |

### `tasks`
| Column | Notes |
|---|---|
| **id** | Primary key |
| title | |
| priority | low / medium / high |
| done | |
| user_id | Foreign key → `users.id` |

### `tags`
| Column | Notes |
|---|---|
| **id** | Primary key |
| name | Unique |

### `task_tags` (linking table)
| Column | Notes |
|---|---|
| **task_id** | Foreign key → `tasks.id` |
| **tag_id** | Foreign key → `tags.id` |

Primary key = **(task_id, tag_id)** together, so the same tag can't be added to the same task twice.

### The data after splitting

**users**

| id | name | email |
|---|---|---|
| 1 | Tala | tala@example.com |
| 2 | Alaa | alaa@example.com |

**tasks**

| id | title | priority | done | user_id |
|---|---|---|---|---|
| 1 | Finish Git task | high | true | 1 |
| 2 | Learn useState | medium | false | 1 |
| 3 | Read React docs | low | false | 2 |
| 4 | Install PostgreSQL | high | false | 2 |

**tags**

| id | name |
|---|---|
| 1 | git |
| 2 | urgent |
| 3 | react |
| 4 | reading |
| 5 | database |

**task_tags**

| task_id | tag_id |
|---|---|
| 1 | 1 |
| 1 | 2 |
| 2 | 3 |
| 3 | 3 |
| 3 | 4 |
| 4 | 5 |
| 4 | 2 |

Now every fact is stored **once**: Tala's email is in one row, and "urgent" is one tag that two tasks point to. All the problems from questions 3, 4 and 5 are solved.
