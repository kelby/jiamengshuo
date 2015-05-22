class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token if Rails.env.development?

  before_filter :create, only: [:weibo, :qq_connect]

  def weibo
  end

  def qq_connect
  end

  def create
    auth = request.env["omniauth.auth"]

    authentication = Authentication.where(provider: auth.provider, uid: auth.uid).first

    if authentication
      user = authentication.user
      unless user
        user = User.new
        user.username = auth.info.name
        user.email = auth.info.email || "#{SecureRandom.hex(6)}@jiamengshuo.com"
        user.build_user_body.location = get_location_from(auth)
        user.password = SecureRandom.hex(8)

        user.save!
      end

      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
    elsif current_user
      current_user.authentications.create!(provider: auth.provider,
                                          uid: auth.uid,
                                          access_token: auth['credentials']['token'],
                                          expires_at: auth['credentials']['expires_at'])
    else
      user = User.new
      user.username = auth.info.name
      user.email = auth.info.email || "#{SecureRandom.hex(6)}@jiamengshuo.com"
      user.build_user_body.location = get_location_from(auth)
      user.password = SecureRandom.hex(8)

      user.save!

      user.authentications.create!(provider: auth.provider,
                                          uid: auth.uid,
                                          access_token: auth['credentials']['token'],
                                          expires_at: auth['credentials']['expires_at'])

      sign_in_and_redirect user, :event => :authentication #this will throw if user is not activated
    end
  end

  private
  def get_location_from(auth)
    if auth.info.location
      auth.info.location
    else
      "#{auth['extra']['raw_info']['province']}#{auth['extra']['raw_info']['city']}"
    end
  end
end
