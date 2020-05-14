class CreateInstrumentalLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :instrumental_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :instrumental, null: false, foreign_key: true

      t.timestamps
    end
    add_index :instrumental_likes, [:user_id, :instrumental_id], unique: true
  end
end
