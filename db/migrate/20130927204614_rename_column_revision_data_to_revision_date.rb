class RenameColumnRevisionDataToRevisionDate < ActiveRecord::Migration
  def change
    [:codes, :movies, :writings].each do |table|
      rename_column table, :revision_data, :revision_date
    end
  end
end
