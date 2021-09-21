FactoryBot.define do
  factory :tagging1, class: Tagging do
    task_id { 1 }
    tag_id {1}
  end

  factory :tagging2, class: Tagging do
    task_id { 1 }
    tag_id {2}
  end
end
