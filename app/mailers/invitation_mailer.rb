class InvitationMailer < ApplicationMailer
  def invitations_instructions
    @resource = params[:user]
    @password = params[:password]
    mail(to: @resource.email, subject: 'Welcome to the Ecommerce App')
  end
end
