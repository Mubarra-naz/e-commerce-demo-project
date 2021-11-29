class InvitationMailer < ApplicationMailer
  def invitations_instructions
    @resource = params[:user]
    @url  = 'http://localhost:3000/'
    mail(to: @resource.email, subject: 'Welcome to the Ecommerce App')
  end
end
