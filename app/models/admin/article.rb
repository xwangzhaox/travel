class Admin::Article < ActiveRecord::Base
  self.table_name = "articles"
  attr_accessible :content, :created_at, :like, :title, :updated_at, :views, :tour_pictures, :tour_pictures_attributes

  has_many :article_category
  has_many :categories , :through => :article_category
  has_many :tour_pictures, :dependent => :destroy
  accepts_nested_attributes_for :tour_pictures, :allow_destroy => true

  def html_content
    self.content.html_safe
  end

  def none_html_content
    self.content.html_safe.gsub(/<.*?>/, "")[0..300]+"..."
  end
end