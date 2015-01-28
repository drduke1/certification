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
    if current_user.permission == "Read Only"
      @tester = true
    elsif current_user.permission != "Read Only"
      @tester = false
    else
      redirect_to signin_url
    end
  end
  
  # Before filters
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
        
end
