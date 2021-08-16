class UsersController < ApplicationController

    # skip_before_action :authorized, only: [:new, :create]

    def new 
        @user = User.new
    end

     def edit
        @user = User.find(current_user.id)
    end
    
    def show
        @user = User.find(params[:id])
        if @user
            render json: {
            user: @user
        }
        else
        render json: {
            status: 500,
            errors: ['user not found']
        }
        end
    end
  
  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to '/welcome'
    else 
        render 'new'
    end
  end


  def update
    @user = User.update(current_user.id, user_params)
    if @user.errors.any?
        render "edit"
    else 
        if current_user.organization_id != nil
            redirect_to profile_path
        else
            redirect_to welcome_path
        end
    end
  end

  def join_organization
    organization = Organization.find(params[:id])
    if organization
        User.update(current_user.id, organization_id: organization.id)
        redirect_to profile_path
    end
  end

  def leave_organization
    User.update(current_user.id, organization_id: nil)
    redirect_to welcome_path
  end
    
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
