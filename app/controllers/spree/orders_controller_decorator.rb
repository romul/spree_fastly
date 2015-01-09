Spree::OrdersController.class_eval do
  before_filter :set_guest_token

  private

  def set_guest_token
    unless cookies.signed[:guest_token].present?
      cookies.permanent.signed[:guest_token] = SecureRandom.urlsafe_base64(nil, false)
    end
  end
end