class CreateInstrumentals < ActiveRecord::Migration[6.0]
  def change
    create_table :instrumentals do |t|
      t.string :title
      t.string :track

      t.timestamps
    end
    add_index :instrumentals, :title, unique: true
  end
end
