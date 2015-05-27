class ChangeMessagesAndCategories < ActiveRecord::Migration
  def change
  	remove_column :products, :category_id

  	drop_table :categories
  	drop_table :messages
  end
end
