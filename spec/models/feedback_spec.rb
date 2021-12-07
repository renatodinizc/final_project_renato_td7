require 'rails_helper'

describe Feedback do
  context 'validation on' do
    it 'body attribute successfully' do
      feedback = Feedback.new

      feedback.valid?

      expect(feedback.errors.full_messages_for(:body)).to include 'Motivo não pode ficar em branco'
      expect(feedback.errors.full_messages_for(:body)).to include 'Motivo é muito curto (mínimo: 10 caracteres)'
    end
  end
end
