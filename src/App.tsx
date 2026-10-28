
import { useState } from 'react'
import './App.css'

import type { Task, FilterType, Priority } from './types'
import TaskForm from './components/TaskForm'
import TaskList from './components/TaskList'
import FilterBar from './components/FilterBar'

function App() {
  const [tasks, setTasks] = useState<Task[]>([])
  const [currentFilter, setCurrentFilter] = useState<FilterType>('all')

  function addTask(title: string, priority: Priority) {
    const newTask: Task = {
      id: Date.now(),
      title,
      priority,
      done: false,
    }

    setTasks((currentTasks) => [...currentTasks, newTask])
  }

  function toggleTask(id: number) {
    setTasks((currentTasks) =>
      currentTasks.map((task) =>
        task.id === id ? { ...task, done: !task.done } : task,
      ),
    )
  }

  function deleteTask(id: number) {
    setTasks((currentTasks) =>
      currentTasks.filter((task) => task.id !== id),
    )
  }

  const filteredTasks = tasks.filter((task) => {
    if (currentFilter === 'active') return !task.done
    if (currentFilter === 'done') return task.done
    return true
  })

  const completedTasks = tasks.filter((task) => task.done).length

  return (
    <main className="app">
      <header className="app-header">
        <h1>Task Tracker</h1>
        <p className="subtitle">
          Organize your tasks, one step at a time.
        </p>
      </header>

      <TaskForm onAddTask={addTask} />

      <section className="task-summary">
        <p>
          {completedTasks} of {tasks.length} tasks done
        </p>
      </section>

      <FilterBar
        currentFilter={currentFilter}
        onFilterChange={setCurrentFilter}
      />

      <TaskList
        tasks={filteredTasks}
        onToggle={toggleTask}
        onDelete={deleteTask}
      />
    </main>
  )
}

export default App
