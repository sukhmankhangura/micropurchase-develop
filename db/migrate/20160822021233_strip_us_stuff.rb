class StripUsStuff < ActiveRecord::Migration
  def change
    remove_column :auctions, :c2_status, :integer, null: false
    remove_column :users, :contracting_officer, :boolean
    remove_column :users, :small_business, :boolean
    remove_column :users, :duns_number, :string
    remove_column :users, :sam_status, :integer
  end
end
