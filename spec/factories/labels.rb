FactoryBot.define do
  factory :label do
    name { '注意' }
  end

  factory :second_label, class: Label do
    name { '保留' }
  end
end