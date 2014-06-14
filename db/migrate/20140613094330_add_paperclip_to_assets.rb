class AddPaperclipToAssets < ActiveRecord::Migration
  def change
    add_column :tour_pictures, :image_file_name, :string
    add_column :tour_pictures, :image_content_type, :string
    add_column :tour_pictures, :image_file_size, :integer
  end

  def down
    delete_column :tour_pictures, :image_file_name
    delete_column :tour_pictures, :image_content_type
    delete_column :tour_pictures, :image_file_size
  end
end
