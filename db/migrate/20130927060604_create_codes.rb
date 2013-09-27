class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :filename
      t.string :title
      t.string :revision
      t.date :revision_data
      t.string :language

      t.timestamps
    end
  end
end
