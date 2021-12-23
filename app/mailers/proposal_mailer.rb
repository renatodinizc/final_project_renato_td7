class ProposalMailer < ApplicationMailer
  def notify_new_proposal
    @proposal = params[:proposal]

    mail to: @proposal.contractor.email, subject: 'Nova proposta para seu projeto' if @proposal.project
  end
end
