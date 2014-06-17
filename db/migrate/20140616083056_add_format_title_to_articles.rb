class AddFormatTitleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :format_title, :string
  end
end
