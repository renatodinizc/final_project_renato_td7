require 'rails_helper'

describe Freelancer do
  context 'validation during profile completion on' do
    it 'the full name attribute successfully' do
      freelancer = Freelancer.new

      freelancer.valid?(:profile_completion)

      expect(freelancer.errors.full_messages_for(:full_name)).to include
      'Nome completo não pode ficar em branco'
    end
    it 'the social name attribute successfully' do
      freelancer = Freelancer.new

      freelancer.valid?(:profile_completion)

      expect(freelancer.errors.full_messages_for(:social_name)).to include
      'Nome social não pode ficar em branco'
    end
    it 'the birth_date attribute successfully' do
      freelancer = Freelancer.new

      freelancer.valid?(:profile_completion)

      expect(freelancer.errors.full_messages_for(:birth_date)).to include
      'Data de nascimento não pode ficar em branco'
    end
    it 'the degree attribute successfully' do
      freelancer = Freelancer.new

      freelancer.valid?(:profile_completion)

      expect(freelancer.errors.full_messages_for(:degree)).to include
      'Formação profissional não pode ficar em branco'
    end
    it 'the description attribute successfully' do
      freelancer = Freelancer.new

      freelancer.valid?(:profile_completion)

      expect(freelancer.errors.full_messages_for(:description)).to include
      'Descrição não pode ficar em branco'
    end
    it 'the description attribute successfully' do
      freelancer = Freelancer.new

      freelancer.valid?(:profile_completion)

      expect(freelancer.errors.full_messages_for(:freelancer_expertise)).to include
      'Área de atuação não pode ficar em branco'
    end
  end
  context 'cannot be younger than 18 years old' do
    it 'successfully' do
      freelancer = Freelancer.new(birth_date: '27/03/2010')

      freelancer.valid?

      expect(freelancer.errors.full_messages_for(:birth_date)).to include
      "Data de nascimento deve ser anterior a #{I18n.l 18.years.ago}"
    end
  end
end
