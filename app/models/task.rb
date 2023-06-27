class Task < ApplicationRecord
  validates :task_name, :detail, presence: true
  belongs_to :user

  enum priority:{
    高: 1,
    中: 2,
    低: 3
  }

  def self.search(search)
    return Task.all unless search
    Task.where('task_name LIKE(?)', "%#{search}%")
  end

  scope :search_by_name_and_status, -> (task_name,status){search(task_name).where(status:status)}
  scope :search_by_name, -> (task_name){search(task_name)}
  scope :search_by_status, -> (status){where(status:status)}
      
end
