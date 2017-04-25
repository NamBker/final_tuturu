class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :address
      t.integer :price
      t.text :description
      t.text :review
      t.string :file

      t.timestamps
    end
  end
end
