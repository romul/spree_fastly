class Spree::Admin::FastlySettingsController < Spree::Admin::BaseController

  def update
    Spree::Fastly::Config.set(params[:preferences])

    respond_to do |format|
      format.html do
        redirect_to edit_admin_fastly_settings_path
      end
    end
  end

end
