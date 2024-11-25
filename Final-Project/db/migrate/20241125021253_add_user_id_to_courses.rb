class AddUserIdToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :user_id, :integer
  end
end
