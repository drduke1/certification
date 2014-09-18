class SessionsController < ApplicationController
	
	def new 
		if signed_in?
			redirect_to questions_path
		end
	end
	
	def create 
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			flash[:success] = 'You have successfully signed in'
			redirect_to questions_path
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end
	
	def destroy 
		sign_out
		redirect_to root_url
	end

end
