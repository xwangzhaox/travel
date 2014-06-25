class AddFormatNameToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :format_name, :string
  end

  def format_date
    Category.all.each do |category|
      category.format_name = category.name.gsub(/ /, "_").downcase
      category.save
    end
  end
end
