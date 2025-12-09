Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Yt.configuration.client_id,
    Yt.configuration.client_secret,
    request_path: "/session/start",
    callback_path: "/session/auth",
    scope: %w[profile email openid drive.file presentations spreadsheets],
    access_type: "offline",
    prompt: "consent"
end

OmniAuth.config.path_prefix = "/session"
OmniAuth.config.request_validation_phase = OmniAuth::AuthenticityTokenProtection.new(key: :_csrf_token)
