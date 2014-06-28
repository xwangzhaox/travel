class AddDescriptionColumnForCategory < ActiveRecord::Migration
  def up
    add_column :categories, :description, :text
  end

  def down
    remove_column :categories, :description, :text
  end
end
