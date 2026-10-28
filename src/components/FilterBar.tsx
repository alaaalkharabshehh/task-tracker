
import type { FilterType } from '../types'

type FilterBarProps = {
  currentFilter: FilterType
  onFilterChange: (filter: FilterType) => void
}

function FilterBar({
  currentFilter,
  onFilterChange,
}: FilterBarProps) {
  const filters: { label: string; value: FilterType }[] = [
    { label: 'All', value: 'all' },
    { label: 'Active', value: 'active' },
    { label: 'Done', value: 'done' },
  ]

  return (
    <div className="filter-bar">
      {filters.map((filter) => (
        <button
          key={filter.value}
          type="button"
          className={`filter-button ${
            currentFilter === filter.value ? 'selected' : ''
          }`}
          onClick={() => onFilterChange(filter.value)}
        >
          {filter.label}
        </button>
      ))}
    </div>
  )
}

export default FilterBar