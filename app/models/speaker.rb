class Speaker < ActiveRecord::Base
  has_many :talks
  has_many :meetings, through: :talks

  validates_presence_of :first_name
end
