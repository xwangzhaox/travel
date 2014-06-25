class AddCategoryColumnScenicSpots < ActiveRecord::Migration
  def up
    add_column :categories, :scenic_spots, :boolean, :default => true
  end

  def down
    remove_column :categories, :scenic_spots
  end
end
