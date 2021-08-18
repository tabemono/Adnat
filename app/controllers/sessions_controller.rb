class SessionsController < ApplicationController

    skip_before_action :authorized, only: [:new, :create]
 

  def create
    @user = User.find_by(email: params[:email])
  
    if @user && @user.authenticate(params[:password])
        login(@user)
        if @user.organization_id == nil
            redirect_to welcome_path
        else
            redirect_to profile_path
        end        
    else
        # render json: ['email or password is invalid'], status: 422
        flash.now.alert = "email or password is invalid"
        render :new
    end
    
  end

  def welcome 
    if current_user.organization_id == nil
        @organization = Organization.new
    else
        redirect_to profile_path
    end
  end

    def destroy 
        @user = current_user
        if @user
            logout
            redirect_to login_path
        else
            # render json: ['Nobody logged in'], status: 404
            flash.now.alert = "Nobody Logged in"
        end
    end

  def profile
    if current_user.organization_id != nil
        @organization = Organization.find(current_user.organization_id)
    else
        redirect_to welcome_path
    end
  end

end