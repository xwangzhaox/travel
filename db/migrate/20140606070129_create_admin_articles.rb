class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.integer :views
      t.integer :like
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def down
    drop_table :articles
  end
end
