class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :filename
      t.string :title
      t.string :revision
      t.date :revision_data
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
