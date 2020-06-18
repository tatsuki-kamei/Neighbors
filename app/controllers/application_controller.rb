class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery prepend: true, with: :exception
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。

	protected
	def after_sign_in_path_for(resource)
		# ログイン後の変遷画面
		# def after_sign_in_path_for(resource)
		user_path(resource)
	end

	# ログアウトと退会後の変遷
	def after_sign_out_path_for(resource)
    	new_user_session_path
 	end

    def configure_permitted_parameters
	    # strong parametersを設定し、user_idを許可
	    # devise_parameter_sanitizer.for(:sign_up){|u|
	    #   u.permit(:user_id, :password, :password_confirmation)
	    # }
	    devise_parameter_sanitizer.permit(:sign_up){|u|
	      u.permit(:user_id, :email, :password, :password_confirmation)
	    }

	    # devise_parameter_sanitizer.for(:sign_in){|u|
	    #   u.permit(:user_id, :password, :remember_me)
	    # }
	    devise_parameter_sanitizer.permit(:sign_in){|u|
	      u.permit(:user_id, :password, :remember_me)
	    }
 	end
end
