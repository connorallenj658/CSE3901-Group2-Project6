class AddCourseToPresentations < ActiveRecord::Migration[7.2]
  def change
    add_reference :presentations, :course, null: false, foreign_key: true
  end
end
