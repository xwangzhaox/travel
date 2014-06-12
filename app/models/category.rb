class Category < ActiveRecord::Base
  attr_accessible :name, :row_num

  has_many :article_category
  has_many :articles , :through => :article_category, class_name: "Admin::Article"
end
