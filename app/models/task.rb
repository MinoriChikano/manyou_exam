class Task < ApplicationRecord
    validates :task_name, :detail, presence: true
end
