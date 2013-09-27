class CreateWritings < ActiveRecord::Migration
  def change
    create_table :writings do |t|
      t.string :filename
      t.string :title
      t.string :revision
      t.date :revision_data

      t.timestamps
    end
  end
end
