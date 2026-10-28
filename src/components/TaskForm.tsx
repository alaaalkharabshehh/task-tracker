
import { useState } from 'react'
import type { FormEvent } from 'react'
import type { Priority } from '../types'

type TaskFormProps = {
  onAddTask: (title: string, priority: Priority) => void
}

function TaskForm({ onAddTask }: TaskFormProps) {
  const [newTask, setNewTask] = useState('')
  const [priority, setPriority] = useState<Priority>('medium')
  const [error, setError] = useState('')

  function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()

    const title = newTask.trim()

    if (!title) {
      setError('Title is required')
      return
    }

    onAddTask(title, priority)
    setNewTask('')
    setPriority('medium')
    setError('')
  }

  return (
    <form className="task-form" onSubmit={handleSubmit}>
      <input
        type="text"
        value={newTask}
        onChange={(event) => {
          setNewTask(event.target.value)
          if (event.target.value.trim()) setError('')
        }}
        placeholder="Enter a new task..."
        aria-label="New task"
      />

      <select
        value={priority}
        onChange={(event) => setPriority(event.target.value as Priority)}
        aria-label="Task priority"
      >
        <option value="low">Low Priority</option>
        <option value="medium">Medium Priority</option>
        <option value="high">High Priority</option>
      </select>

      <button type="submit">Add Task</button>

      {error && <p className="error-message">{error}</p>}
    </form>
  )
}

export default TaskForm
