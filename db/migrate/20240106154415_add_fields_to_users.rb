class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :relationship, :string
  end
end
