FactoryBot.define do
  factory :task do
    task_name { 'タスク1' }
    detail { '詳細1' }
    expired_at {'2023/06/16'}
    status { '未着手' }
  end
  
  factory :second_task, class: Task do
    task_name { 'タスク2' }
    detail { '詳細2' }
    expired_at { '2023/06/17' }
    status { '着手中' }
  end
  
  factory :third_task, class: Task do
    task_name { 'タスク3' }
    detail { '詳細3' }
    expired_at { '2023/06/18' }
    status { '完了' }
  end
end
