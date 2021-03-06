class Tag < ApplicationRecord
  has_many :tasks
  has_one :user
  has_many :taggings, dependent: :delete_all
  has_many :tagging_tasks, through: :taggings, source: :task


end
