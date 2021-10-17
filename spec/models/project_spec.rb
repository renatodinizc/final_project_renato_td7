require 'rails_helper'

describe Project do
  context 'validation on' do
    it 'the title attribute successfully' do
      project = Project.new

      project.valid?
      
      expect(project.errors.full_messages_for(:title)).to include('Título não pode ficar em branco')
    end
    it 'the description attribute successfully' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:description)).to include("Descrição não pode ficar em branco")
    end
    it 'the desired skills attribute successfully' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:desired_skills)).to include("Habilidades preferenciais não pode ficar em branco")
    end
    it 'the proposal deadline attribute successfully' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:proposal_deadline)).to include("Prazo de submissão final não pode ficar em branco")
    end
    it 'the freelancer expertise attribute successfully' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:freelancer_expertise)).to include 'Área de atuação é obrigatório(a)'
    end
  end

  context 'custom validation on' do
    it 'top hourly wage successfully' do
      object = Project.new(top_hourly_wage: -5)
      
      object.valid?

      expect(object.errors.full_messages_for(:top_hourly_wage)).to include 'Máximo preço por hora não pode ser negativo'
      
    end
  end
end