class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :complement, :string
    add_column :users, :region, :string
    add_column :users, :state, :string
    add_column :users, :landphone, :string
    add_column :users, :celphone, :string
  end
end
