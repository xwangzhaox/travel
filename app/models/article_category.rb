class ArticleCategory < ActiveRecord::Base
  attr_accessible :article_id, :category_id

  belongs_to :article, class_name: "Admin::Article"
  belongs_to :category
end
