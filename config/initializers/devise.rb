Devise.setup do |config|
  config.secret_key = '6c7412f606e30338f3f07ed35af498d7b4518041c3163fdf5bac406d515f622e96cfbddbd8549d6565f53fa1d439191191745c6f9746c20f14db99295e0b0851'
  config.mailer_sender = ENV['SMTP_USERNAME']
  config.authentication_keys = [:email]
end
