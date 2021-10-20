require 'rails_helper'

describe Chat do
  context 'validation on' do
    it 'the commenter attribute successfully' do
      chat = Chat.new

      chat.valid?

      expect(chat.errors.full_messages_for(:commenter)).to include 'Remetente não pode ficar em branco'
    end
    
    it 'the message attribute successfully' do
      chat = Chat.new

      chat.valid?

      expect(chat.errors.full_messages_for(:message)).to include 'Mensagem não pode ficar em branco'
    end
    
  end
end
