class InvitationMailer < ApplicationMailer
  def invite(invitation,account_status)

    if account_status == 'invite'
        @urltype = 'sign-up'
      else 
        @urltype = 'sign-in'
      end

    @invitation = invitation
    mail(
      to: invitation.email,
      subject: "Invitation to join #{invitation.account.subdomain} on SpidaGram"
    )
  end
end
