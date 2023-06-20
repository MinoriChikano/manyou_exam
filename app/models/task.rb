class Task < ApplicationRecord
  validates :task_name, :detail, presence: true

  def self.search(search)
    return Task.all unless search
    Task.where('task_name LIKE(?)', "%#{search}%")
  end

  scope :search_by_name_and_status, -> (task_name,status){search(task_name).where(status:status)}
  scope :search_by_name, -> (task_name){search(task_name)}
  scope :search_by_status, -> (status){where(status:status)}
      
end
