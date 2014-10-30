class UserMailer < ActionMailer::Base
  default from: "certification@grandstream.com"
  
  def new_user(user)
    @user = user
    mail(to: "certification@grandstream.com", :bcc => "david.duke@grandstream.com", subject: 'Grandstream Certification - New Application Submitted')
  end
  
  def reset_email(user)
    @user = user
    mail(:to => user.email, :bcc => "david.duke@grandstream.com", :subject => "Certification Portal Password Reset")
  end
end
