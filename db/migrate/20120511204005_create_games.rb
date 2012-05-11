class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :first_transcription
      t.text :last_transcription
      t.string :first_recording
      t.string :last_recording
      t.integer :similarity
      t.boolean :started
      t.boolean :finished

      t.timestamps
    end
  end
end
