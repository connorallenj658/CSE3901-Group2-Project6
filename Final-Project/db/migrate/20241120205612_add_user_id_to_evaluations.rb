class AddUserIdToEvaluations < ActiveRecord::Migration[6.1]
  def change
    # Add user_id column without NOT NULL constraint first
    add_reference :evaluations, :user, foreign_key: true

    # Backfill user_id for existing evaluations (associate them with the first user or another default)
    reversible do |dir|
      dir.up do
        # Associate existing evaluations with the first user in the users table, or create a dummy user
        default_user = User.first || User.create!(email: "default@example.com", password: "password", role: "student")
        Evaluation.update_all(user_id: default_user.id)
      end
    end

    # Change user_id to NOT NULL after backfilling
    change_column_null :evaluations, :user_id, false
  end
end
