class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    case current_user.role.name
      when 'host'
        redirect_to properties_url
      when 'guest'
        redirect_to properties_url
    end
  end
end
