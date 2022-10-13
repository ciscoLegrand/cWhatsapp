class PagesController < ApplicationController
  def index
    
  end

  def dashboard
  end

  def send_welcome
    w = WhatsappManager.new
    w.send_message("welcome_blipol", "34625650792".to_i, "creaDix","cisco", SecureRandom.hex)
    redirect_to root_path
  end
end
