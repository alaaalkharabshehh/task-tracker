
import type { Task } from '../types'

type TaskItemProps = {
  task: Task
  onToggle: (id: number) => void
  onDelete: (id: number) => void
}

function TaskItem({ task, onToggle, onDelete }: TaskItemProps) {
  return (
    <li className={`task-item priority-${task.priority}`}>
      <label className={task.done ? 'completed' : ''}>
        <input
          type="checkbox"
          checked={task.done}
          onChange={() => onToggle(task.id)}
        />

        <span>{task.title}</span>
      </label>

      <span className={`priority-badge ${task.priority}`}>
        {task.priority.charAt(0).toUpperCase() + task.priority.slice(1)}
      </span>

      <button
        type="button"
        className="delete-button"
        onClick={() => onDelete(task.id)}
      >
        Delete
      </button>
    </li>
  )
}

export default TaskItem