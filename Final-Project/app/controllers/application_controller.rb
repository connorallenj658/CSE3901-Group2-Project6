class ApplicationController < ActionController::Base
  # Redirect to the login page after signing out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  def after_sign_in_path_for(resource_or_scope)
    courses_path
  end
end
