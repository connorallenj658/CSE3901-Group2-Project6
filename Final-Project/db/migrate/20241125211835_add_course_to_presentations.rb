class AddCourseToPresentations < ActiveRecord::Migration[7.0]
  def change
    # Temporarily allow null values to bypass existing records
    add_reference :presentations, :course, foreign_key: true
  end
end
