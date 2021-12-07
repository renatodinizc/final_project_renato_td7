require 'rails_helper'

describe FreelancerExpertise do
  context 'validates title' do
    it 'successfully' do
      expertise = FreelancerExpertise.new

      expertise.valid?

      expect(expertise.errors.full_messages_for(:title)).to include 'Área de atuação não pode ficar em branco'
    end
  end
end
