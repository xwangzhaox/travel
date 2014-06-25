class AddSuperCategoryToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :super_category, :string
  end
end
