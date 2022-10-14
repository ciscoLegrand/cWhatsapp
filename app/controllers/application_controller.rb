class ApplicationController < ActionController::Base
  before_action :set_token
  private
  def set_token
    return cookies[:data] if defined? cookies[:data]

    cookies[:data] ||= 'no hay token'
  end
end
