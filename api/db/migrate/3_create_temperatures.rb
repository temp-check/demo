class CreateTemperatures < ActiveRecord::Migration[7.1]
  def change
    create_table :temperatures, id: :uuid do |t|
      t.json :forecast
      t.references :postal_code, null: false, foreign_key: true, type: :uuid
      t.boolean :cached, default: true
      t.timestamps
    end
  end
end
