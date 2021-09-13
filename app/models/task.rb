class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :limit_date, presence: true
  validates :content, presence: true
  validates :priority, presence: true
  enum priority: {low: 1, medium: 2 , high: 3}

  scope :get_all, ->(){order(limit_date: :desc)}
  scope :search_name, ->(name){where('name like ?', name)}
  scope :search_status, ->(status){where('status like ?', status)}
  scope :name_status_search, ->(name,status){where('name like ? and status like ?', name, status)}
  scope :sort_priority, ->(){order(priority: :desc)}
end
