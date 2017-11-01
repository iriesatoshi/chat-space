class AddIndexToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, index: true, unique: true
  end
end
