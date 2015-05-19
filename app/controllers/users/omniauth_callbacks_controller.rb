class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def weibo
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.from_omniauth(request.env["omniauth.auth"])

    # if @user.persisted?
    #   sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    #   set_flash_message(:notice, :success, :kind => "Weibo") if is_navigational_format?
    # else
    #   session["devise.weibo_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    # end


    omniauth = request.env["omniauth.auth"]
    omniauth['credentials']['expires_at'] = Time.at(omniauth['credentials']['expires_at'])
    # raise omniauth.to_yaml
    # authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    authentication = Authentication.where(provider: omniauth['provider'], uid: omniauth['uid']).first

    if authentication
      authentication.access_token = omniauth['credentials']['token']
      authentication.expires_at = omniauth['credentials']['expires_at']
      authentication.save

      # update user
      user = authentication.user
      user.username = omniauth['info']['nickname']
      # raw_info = omniauth['extra']['raw_info']
      # user.remote_avatar_url = raw_info['avatar_large']
      user.save!

      sign_in_and_redirect(authentication.user)
    elsif current_user
      current_user.authentications.create!(
        :provider => omniauth['provider'],
        :uid => omniauth['uid'],
        :access_token => omniauth['credentials']['token'],
        :expires_at => omniauth['credentials']['expires_at'])

      current_user.apply_omniauth(omniauth)
      current_user.save!
      redirect_to root_path
    else
      user = User.new
      user.apply_omniauth(omniauth)

      if session[:invitation_token]
        user.invitation_token = session[:invitation_token]
        user.email = user.invitation.recipient_email
      end

      if user.save!
        session[:invitation_token] = nil
        sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Weibo") if is_navigational_format?
      else
        session["devise.user_attributes"] = user.attributes
        session["devise.auth"] = user.authentications.first.attributes
        redirect_to new_user_registration_path
      end
    end
  end

  def qq_connect
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.qq_connect_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
