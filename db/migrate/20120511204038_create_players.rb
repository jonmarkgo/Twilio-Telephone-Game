class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :game
      t.string :phone_number
      t.integer :position
      t.string :name
      t.string :recording_url

      t.timestamps
    end
    add_index :players, :game_id
  end
end
