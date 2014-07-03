class AddTourCodeAndQuotationForArticle < ActiveRecord::Migration
  def up
    add_column :articles, :tour_code, :string
    add_column :articles, :quotation, :string
  end

  def down
    remove_column :articles, :tour_code
    remove_column :articles, :quotation
  end
end
