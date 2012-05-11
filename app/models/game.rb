class Game < ActiveRecord::Base
  attr_accessible :finished, :first_recording, :first_transcription, :last_recording, :last_transcription, :similarity, :started
  has_many :players, :order => "position"
end
