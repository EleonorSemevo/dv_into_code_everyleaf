class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :limit_date
      t.string :status
      t.text :content
      t.string :priority

      t.timestamps
    end
    change_column :tasks,:name, :string, null: false
  end
end
