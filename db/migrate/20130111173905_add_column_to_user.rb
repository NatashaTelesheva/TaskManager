class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :is_active, :boolean
  end
end
