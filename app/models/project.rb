class Project < ActiveRecord::Base
  has_many :tasks
  attr_accessible :name
  scope :like_name, lambda { |value| where('projects.name like ?', value + '%') if value }
  validates :name, :length => { :minimum => 2, :maximum => 40 }
end
