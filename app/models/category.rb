class Category < ActiveRecord::Base
  attr_accessible :name, :row_num, :description

  has_many :article_category
  has_many :articles , :through => :article_category, class_name: "Admin::Article"

  def sub_categories
    arr = []
    self.super_category.split(",").each{|x|arr << Category.find_by_id(x.to_i)}
    arr
  end
end
