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
end