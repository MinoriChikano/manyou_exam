class Task < ApplicationRecord
  validates :task_name, :detail, presence: true

  def self.search(search)
    return Task.all unless search
    Task.where('task_name LIKE(?)', "%#{search}%")
  end
      
end
