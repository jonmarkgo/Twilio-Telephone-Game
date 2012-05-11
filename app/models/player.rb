class Player < ActiveRecord::Base
  belongs_to :game
  attr_accessible :name, :phone_number, :position, :recording_url
end
