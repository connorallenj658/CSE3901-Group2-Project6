class AddUserToPresentations < ActiveRecord::Migration[6.1]
  def change
    # Add the user_id column without the NOT NULL constraint first
    add_reference :presentations, :user, foreign_key: true

    # Backfill the user_id column with a default user (e.g., the first user in the database)
    reversible do |dir|
      dir.up do
        # Find or create a default user (adjust email/password/role as necessary)
        default_user = User.first || User.create!(email: "default@example.com", password: "password", role: "teacher")
        Presentation.update_all(user_id: default_user.id)
      end
    end

    # Then apply the NOT NULL constraint to the user_id column
    change_column_null :presentations, :user_id, false
  end
end
