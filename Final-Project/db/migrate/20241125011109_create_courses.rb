class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:courses)
      create_table :courses do |t|
        t.string :name
        t.string :description
        t.integer :credits

        t.timestamps
      end
    end
  end
end
