class AddUserDetailsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :about_me, :text
  end
end
