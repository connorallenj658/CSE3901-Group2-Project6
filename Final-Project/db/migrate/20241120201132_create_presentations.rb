class CreatePresentations < ActiveRecord::Migration[7.2]
  def change
    create_table :presentations do |t|
      t.string :title
      t.datetime :date
      t.timestamps
      t.string :description
      t.string :credits
    end
  end
end
