require 'rails_helper'

RSpec.describe Proposal, type: :mailer do
  context 'new proposal' do
    it 'should notify contractor' do
      renato = create(:contractor, email: 'renato@hub.com')
      proposal = create(:proposal, contractor: renato)

      mail = ProposalMailer.with(proposal: proposal).notify_new_proposal

      expect(mail.to).to eq ['renato@hub.com']
      expect(mail.from).to eq ['nao-responda@hub.com']
      expect(mail.subject).to eq 'Nova proposta para seu projeto'
      expect(mail.body).to include 'Olá, renato@hub'
      expect(mail.body).to include
      "Seu projeto 'Project 1' recebeu uma nova propostado freelancer Freelancer 1!"
    end
  end
end
