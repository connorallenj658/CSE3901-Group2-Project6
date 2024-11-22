class AddDescriptionToPresentations < ActiveRecord::Migration[7.2]
  def change
    add_column :presentations, :description, :text
  end
end
