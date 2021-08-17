class ApplicationController < ActionController::Base
    before_action :authorized, except: [:new, :create]
    helper_method :current_user
    helper_method :logged_in?

    def login(user)
        session[:session_token] = user.reset_session_token! 
    end

    def current_user 
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end


    def logged_in?
        !!current_user
    end


    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def authorized
        redirect_to '/login' unless logged_in?
    end

end
