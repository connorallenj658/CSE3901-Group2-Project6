class DropCourses < ActiveRecord::Migration[7.2]
  def change
    drop_table :courses
  end
end
