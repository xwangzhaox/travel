class TourPicture < ActiveRecord::Base
  attr_accessible :article_id, :image_file_name, :image_file_size, :image_content_type, :image
  belongs_to :article, class_name: "Admin::Article"

  has_attached_file :image,
    :default_style => :s120,
    :styles => {
      :max => "600x400>",
      :normal => "180x180>",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      }#,
    # :url => "/uploadfiles/:class/:attachment/:id/:basename/:style.:extension",
    # :path => ":rails_root/public/uploadfiles/:class/:attachment/:id/:basename/:style.:extension"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"], :allow_nil => true 
end