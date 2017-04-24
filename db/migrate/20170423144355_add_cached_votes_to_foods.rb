class AddCachedVotesToFoods < ActiveRecord::Migration[5.0]
  def self.up
    add_column :foods, :cached_votes_up, :integer, default: 0
  end
end
