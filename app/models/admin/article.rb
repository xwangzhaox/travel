class Admin::Article < ActiveRecord::Base
  self.table_name = "articles"
  attr_accessible :content, :created_at, :like, :title, :updated_at, :views

  has_many :article_category
  has_many :categories , :through => :article_category
end
