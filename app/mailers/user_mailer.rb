class UserMailer < ActionMailer::Base  
  def forgot_password(member)
    @user = member
    mail(
      :to            => @user.email,
      :from          => 'noreply@foulbricks.com',
      :subject       => 'Account Password Reset',
      :template_path => '/mailers/user_mailer'
    )
  end
  
  def new_user(member)
    @user = member
    mail(
      :to             => "rowingskimos@gmail.com",
      :from           => "noreply@foulbricks.com",
      :subject        => "A New Account Has Been Created",
      :template_path   => "/mailers/user_mailer"
    )
  end
  
  def welcome(member)
    @user = member
    mail(
      :to             => @user.email, 
      :from           => 'noreply@foulbricks.com',
      :subject        => 'Please Activate Your Account',
      :template_path  => '/mailers/user_mailer'
    )
  end
end