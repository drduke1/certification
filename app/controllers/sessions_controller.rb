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
	
  def reset    
      if params[:session]
        if user = User.find_by_email(params[:session][:email].downcase)
          if user.update_attribute(:validate_code, SecureRandom.urlsafe_base64(10))
            flash[:success] = "Thank you. Please check your email for the password reset instructions."
            
            #send email with validate_code here
            UserMailer.reset_email(user).deliver
            redirect_to signin_path
          end         
        end
      else
        flash[:success] = "Your email address was not found."
      end
    end
      
    def reset_password
      if params[:session]
        if (user = User.find_by_email(params[:session][:email].downcase))
          if user.validate_code = params[:session][:confirmation_code]
            if user.update_attributes(session_params)
              #set validate_code back to 0
              user.update_attribute(:validate_code, "0")
              flash[:success] = "Password successfully changed"
              redirect_to signin_path
            else
              render 'reset_password'
            end
          else
            flash.now[:error] = 'Sorry, your email address/confirmation code does not match'
            render 'reset_password'
          end
        end
      end
    end 
	
	def destroy 
		sign_out
		redirect_to root_url
	end
	
	private
	
  def session_params
        params.require(:session).permit(:name, :email, :password, :password_confirmation )
  end

end
