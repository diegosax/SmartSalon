class AddCreatedByToEvents < ActiveRecord::Migration
  def change
    add_column :events, :created_by, :string
  end
end
