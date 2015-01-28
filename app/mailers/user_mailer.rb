class UserMailer < ActionMailer::Base
  default from: "certification@grandstream.com"
  
  def welcome_email(user)
    @user = user
    mail(to: "user.email", :bcc => "david.duke@grandstream.com", subject: 'Grandstream Certification - New User')
  end
  
  def reset_email(user)
    @user = user
    mail(:to => user.email, :bcc => "david.duke@grandstream.com", :subject => "Certification Portal Password Reset")
  end
end
