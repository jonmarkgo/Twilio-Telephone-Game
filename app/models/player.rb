class Player < ActiveRecord::Base
  belongs_to :game
  acts_as_list :scope => :game
  attr_accessible :name, :phone_number, :position, :recording_url
end
