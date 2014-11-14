class StaticPagesController < ApplicationController
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
end
