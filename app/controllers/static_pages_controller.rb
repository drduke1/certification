class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:overview]
  
  def home
    begin
    sign_out
    @user = User.new
    rescue
    @user = User.new
    end
  end

  def help
  end
  
  def overview
  end
  
  # Before filters
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
        
end
