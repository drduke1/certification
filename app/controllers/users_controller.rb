class UsersController < ApplicationController
  before_filter :permitted, only: [:show, :update, :edit]
  before_action :set_user, 			 only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:edit, :show, :update]
  before_action :admin_user, 		 only: [:index, :destroy]
  
  unless :admin_user
    before_action :correct_user,    only: [:edit, :update]
	end

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit

  end

  # POST /users
  # POST /users.json
  def create
    if user = User.find_by(email: params[:user][:email].downcase)
    #begin 
      #unless user.permission != "Read Only"    
        if params[:user][:taking] == "taking"
          sign_in user
          code = params[:user][:code]
          redirect_to new_score_path(request.parameters)
        else
         redirect_to user, notice: 'User already exists.'
        end
      #end
    #rescue
    #  redirect_to root_path, notice: "Testing your knowledge?"
    #end
    else
      if params[:user][:taking] == "taking"
        password = SecureRandom.urlsafe_base64(8)
        params[:user][:password] = password
        params[:user][:password_confirmation] = password
        params[:user][:permission] = ["Read Only"]
        code = params[:user][:code]
        if Test.where(id: code).present? == false
          redirect_to home_path, notice: 'The code entered is invalid'
        else
          @user = User.new(user_params)
          user = @user
          respond_to do |format|
            if @user.save
              sign_in user
              format.html { redirect_to new_score_path(request.parameters), notice: 'Please answer all questions' }
            else
              format.html { redirect_to home_path }
            end
          end
        end
      else
        @user = User.new(user_params)
          respond_to do |format|
            if @user.save
              format.html { redirect_to @user, notice: 'User was successfully created.' }
              format.json { render action: 'show', status: :created, location: @user }
            else
              format.html { render action: 'new' }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password] == ''
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      if @user.update_attributes(user_nopass_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    else
      if @user.update_attributes(user_params)
      	flash[:success] = "Profile updated"
      	redirect_to @user
      else
      	render 'edit'
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy 
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if current_user.admin?
        @user = User.find(params[:id])
      else
        @user = current_user
      end      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :taking, :code, :permission => [])
    end
    
    def user_nopass_params
      params.require(:user).permit(:name, :email, :admin, :permission => [])
    end
    
    # Before filters
    def signed_in_user
    	unless signed_in?
    		store_location
	    	redirect_to signin_url, notice: "Please sign in."
	    end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
    	redirect_to(root_url) unless current_user.admin?
    end
    
end
