class AddNameAddAvatarAddBirthAddGenderToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :text
    add_column :users, :birth, :string
    add_column :users, :gender, :string,unique: true
  end
end
