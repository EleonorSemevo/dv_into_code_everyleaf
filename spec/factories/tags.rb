FactoryBot.define do
  factory :tag1, class: Tag do
    name { 'tag1' }
    user_id {1}
  end
  factory :tag2, class: Tag do
    name { 'tag2' }
    user_id {1}
  end
end
