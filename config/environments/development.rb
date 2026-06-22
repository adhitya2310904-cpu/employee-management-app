require "active_support/core_ext/integer/time"

Rails.application.configure do

  config.action_mailer.delivery_method = :smtp
  config.eager_load = false
  config.active_storage.service = :local

  config.action_mailer.smtp_settings = {
    address: "sandbox.smtp.mailtrap.io",
    port: 2525,
    user_name: "98c6dd1345e395",
    password: "e00a3d93140c72",
    authentication: :plain
  }

  config.action_mailer.default_url_options = {
    host: "localhost",
    port: 3000
  }

end