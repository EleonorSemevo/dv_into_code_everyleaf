class Task < ApplicationRecord
  validates :name, presence: true, length: {minimum: 1}
  validates :status, presence: true
  validates :limit_date, presence: true
  validates :content, presence: true
  validates :priority, presence: true
end
