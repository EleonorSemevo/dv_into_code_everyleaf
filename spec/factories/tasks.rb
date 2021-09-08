FactoryBot.define do
  factory :task do
    # Veuillez modifier le contenu suivant en fonction du nom de colonne réellement créé
    name { 'task' }
    content { 'some content' }
    status { 'finished' }
    priority { 'middle' }
    limit_date { Date.new(2021, 9, 9) }
  end

  factory :second_task, class: Task do
    name { 'test2 name' }
    content { 'some content' }
    content { 'some content' }
    status { 'test2 status' }
    priority { 'middle' }
    limit_date { Date.new(2021, 4, 4) }
  end
end
