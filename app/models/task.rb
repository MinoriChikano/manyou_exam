class Task < ApplicationRecord
  validates :task_name, :detail, presence: true

  def self.search(search)
    return Task.all unless search
    Task.where('task_name LIKE(?)', "%#{search}%")
  end

  scope :search_by_keyword_and_status, -> (keyword,status){search(keyword).where(status:status)}
  scope :search_by_keyword, -> (keyword){search(keyword)}
  scope :search_by_status, -> (status){where(status:status)}
      
end
