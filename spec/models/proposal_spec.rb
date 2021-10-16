require 'rails_helper'

describe Proposal do
  context 'validation on' do
    it 'the proposal description attribute successfully' do
      proposal = Proposal.new

      proposal.valid?

      expect(proposal.errors.full_messages_for(:proposal_description)).to include 'Descrição da proposta não pode ficar em branco'
    end
    it 'the hourly wage attribute successfully' do
      proposal = Proposal.new

      proposal.valid?

      expect(proposal.errors.full_messages_for(:hourly_wage)).to include 'Valor/hora não pode ficar em branco'
    end
    it 'the weekly hours attribute successfully' do
      proposal = Proposal.new

      proposal.valid?

      expect(proposal.errors.full_messages_for(:weekly_hours)).to include 'Horas semanais não pode ficar em branco'
    end
    it 'the expected conclusion attribute successfully' do
      proposal = Proposal.new

      proposal.valid?

      expect(proposal.errors.full_messages_for(:expected_conclusion)).to include 'Conclusão esperada não pode ficar em branco'
    end
  end
  
end