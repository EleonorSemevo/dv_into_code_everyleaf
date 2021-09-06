class Task < ApplicationRecord
  validates :name, presence: true, length: {minimum: 1}
  validates :status, presence: true
  validates :limit_date, presence: true
end
