module ApplicationHelper
  def google_auth_url
    store_request_url if signed_in? && request.get?
    "/session/start"
  end
end
