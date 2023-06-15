FactoryBot.define do
    factory :task do
      task_name { 'task_name' }
      detail { 'detail' }
    end

    factory :second_task, class: Task do
      task_name { 'Factoryで作ったデフォルトのタイトル2' }
      detail { 'Factoryで作ったデフォルトのコンテント2' }
    end
  end