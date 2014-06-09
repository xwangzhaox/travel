class Admin::Article < ActiveRecord::Base
  self.table_name = "articles"
  attr_accessible :content, :created_at, :like, :title, :updated_at, :views
end
