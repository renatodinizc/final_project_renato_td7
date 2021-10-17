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

    it "custom attribute 'check for top wage' successfully" do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                                    social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                                    description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                                    experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
      desafios = Project.create!(title: 'Plataforma de desafios de programação',
                                description: 'Pessoal da Campus Code',
                                desired_skills: 'Esforçada, obstinada e cuidadosa',
                                top_hourly_wage: 37,
                                proposal_deadline: '22/01/2022',
                                remote: true,
                                contractor: peter,
                                freelancer_expertise: webdev)
      proposal = Proposal.new(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma',
                                  hourly_wage: 40, weekly_hours: 12, expected_conclusion: '10/01/2022',
                                  project: desafios, freelancer: spongebob)

      proposal.valid?

      expect(proposal.errors.full_messages_for(:hourly_wage)).to include 'Valor/hora não pode exceder o máximo preço por hora do projeto'
    end
  end
end