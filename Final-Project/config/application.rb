require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinalProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Autoload lib directory but ignore non-Ruby files
    config.autoload_lib(ignore: %w[assets tasks])

    # Action Mailer default configurations
    config.action_mailer.perform_caching = false
    config.action_mailer.default_options = { from: 'no-reply@yourapp.com' }

    # Add custom eager load paths (e.g., services, interactors)
    config.eager_load_paths << Rails.root.join("app", "services")

    # Time zone and localization
    config.time_zone = "Eastern Time (US & Canada)"
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    # Middleware for additional security (optional)
    # config.middleware.use Rack::Attack

    # Credentials-based Action Mailer configuration
    config.action_mailer.smtp_settings = {
      address: Rails.application.credentials.dig(:smtp, :address) || "smtp.gmail.com",
      port: Rails.application.credentials.dig(:smtp, :port) || 587,
      domain: Rails.application.credentials.dig(:smtp, :domain) || "gmail.com",
      user_name: Rails.application.credentials.dig(:smtp, :user_name),
      password: Rails.application.credentials.dig(:smtp, :password),
      authentication: :plain,
      enable_starttls_auto: true
    }

    # Configuration for the application, engines, and railties goes here.
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
