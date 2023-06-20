FactoryBot.define do
  factory :task do
    task_name { 'task_name' }
    detail { 'detail' }
    expired_at {'expired_at'}
    status { 'status' }
  end
  
  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル2' }
    detail { 'Factoryで作ったデフォルトのコンテント2' }
    expired_at { 'Factoryで作ったデフォルトの締切2' }
    status { 'Factoryで作ったデフォルトのステイタス2' }
  end
  
end
