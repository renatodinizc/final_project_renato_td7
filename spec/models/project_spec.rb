require 'rails_helper'

describe Project do
  context 'validation on' do
    it 'the title attribute successfuly' do
      project = Project.new

      project.valid?
      
      expect(project.errors.full_messages_for(:title)).to include('Título não pode ficar em branco')
    end
    it 'the description attribute successfuly' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:description)).to include("Descrição não pode ficar em branco")
    end
    it 'the desired skills attribute successfuly' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:desired_skills)).to include("Habilidades preferenciais não pode ficar em branco")
    end
    it 'the proposal deadline attribute successfuly' do
      object = Project.new
      object.valid?
      expect(object.errors.full_messages_for(:proposal_deadline)).to include("Prazo de submissão final não pode ficar em branco")
    end
  end
end