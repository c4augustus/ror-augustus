class CreateDiagrams < ActiveRecord::Migration
  def change
    create_table :diagrams do |t|
      t.string :filename
      t.string :title
      t.string :revision
      t.date :revision_date
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
