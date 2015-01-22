ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "grandstream.com",
  :user_name => "certification@grandstream.com",
  :password => "gr@ndstre@m",
  :authentication => "plain",
  :enable_starttls_auto => true
}