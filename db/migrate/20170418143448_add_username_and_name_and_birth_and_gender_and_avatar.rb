class AddUsernameAndNameAndBirthAndGenderAndAvatar < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string, unique: true
    add_column :users, :name, :string
    add_column :users, :birth, :date
    add_column :users, :gender, :boolean
    add_column :users, :avatar, :string
  end
end
