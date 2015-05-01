Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, "555098778", "54266777d7296f3f5affc527b3778341"
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :developer unless Rails.env.production?
#   provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
# end
