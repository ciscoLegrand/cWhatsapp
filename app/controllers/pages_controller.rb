class PagesController < ApplicationController
  def index
  end

  def dashboard
  end

  def send_welcome
    w = WhatsappManager.new
    @response = w.send_message("welcome_blipol", "34625650792".to_i, "creaDix","cisco", SecureRandom.hex)
    cookies[:data] = @response.to_json
    redirect_to root_path
  end
end
