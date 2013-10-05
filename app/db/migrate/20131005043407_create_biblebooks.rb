class CreateBiblebooks < ActiveRecord::Migration
  def change
    create_table :biblebooks do |t|
      t.string :title
      t.string :author
      t.date :published_at
      t.text :intro
      t.text :extended
      t.string :chapter
      t.string :biblebook
      t.integer :order

      t.timestamps
    end
  end
end
