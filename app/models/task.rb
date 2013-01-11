class Task < ActiveRecord::Base
  belongs_to :project
  attr_accessible :name, :status
  scope :like_name, lambda { |value| where('name like ?', value + '%') if value }
  validates :name, :length => { :minimum => 2, :maximum => 40 }
  validates :status, :length => { :minimum => 2, :maximum => 20 }
end
