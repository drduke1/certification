module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.hash(remember_token))
		self.current_user = user
	end
	
	def signed_in?
		!current_user.nil?
	end

	def admin_user?
		current_user.admin?
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		remember_token = User.hash(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
	
	def current_user?(user)
		user == current_user
	end
	
	def sign_out
		current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	
	def store_location
		session[:return_to] = request.url if request.get?
	end
	
  def permitted
    begin
    @permission = current_user.permission
      if @permission.include?("Read Only")
        begin
          redirect_to signin_url
        rescue
          return false
        end
        
      else
        return true
      end
    rescue
      return false
    end
  end

end
