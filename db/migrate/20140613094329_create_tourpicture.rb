class CreateTourPictures < ActiveRecord::Migration
  def change
    create_table :tour_pictures do |t|
      t.integer :article_id

      t.timestamps
    end
  end

  def down
    drop_table :tour_pictures
  end
end