class UserMailer < ApplicationMailer
  default from: 'SocialNetworkingSite@example.com'

  def post_created
    @user = params[:user]
    @post_user = params[:post_user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @post_user.email, subject: 'There is a new comment on your post')
  end
end
