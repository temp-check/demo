class CreatePostalCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :postal_codes, id: :uuid do |t|
      t.string :code, null: false, default: ""

      t.timestamps
    end
  end
end
