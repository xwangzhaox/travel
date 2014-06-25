class AddArticleColumnIsTouristRoute < ActiveRecord::Migration
  def up
    add_column :articles, :is_tourist_route, :boolean, :default => true
  end

  def down
    remove_column :articles, :is_tourist_route
  end
end
