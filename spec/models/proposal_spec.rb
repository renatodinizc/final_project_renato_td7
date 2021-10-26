require 'rails_helper'

describe Proposal do
  context 'validation on' do
    it 'the proposal description attribute successfully' do
      proposal = Proposal.new

      proposal.valid?

      expect(proposal.errors.full_messages_for(:proposal_description)).to include 'Justificativa não pode ficar em branco'
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
      
    it 'approval status when proposal created' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')        
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                                social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                                description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
                                freelancer_expertise: webdev)                         
      website = Project.create!(title: 'Website para grupo de estudos',
                                description: 'Grupo de estudos liberal de Salvador',
                                desired_skills: 'Orientado a prazos e qualidade',
                                top_hourly_wage: 20,
                                proposal_deadline: '10/12/2021',
                                remote: true,
                                contractor: peter,
                                freelancer_expertise: webdev)
      proposal = Proposal.create!(proposal_description: 'Quero muito contribuir',
                                  hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                  project: website, freelancer: jane, contractor: peter)

      expect(proposal.status).to eq 'pending_approval'
    end
    it 'uniqueness per freelancer successfull' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                                    social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                                    description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                                    experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
      desafios = Project.create!(title: 'Plataforma de desafios de programação',
                                description: 'Pessoal da Campus Code',
                                desired_skills: 'Esforçada, obstinada e cuidadosa',
                                top_hourly_wage: 67,
                                proposal_deadline: 10.days.from_now,
                                remote: true,
                                contractor: peter,
                                freelancer_expertise: webdev)
      proposal = Proposal.create!(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma',
                              hourly_wage: 32, weekly_hours: 12, expected_conclusion: 20.days.from_now,
                              project: desafios, freelancer: spongebob, contractor: peter)
      proposal2 = Proposal.new(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma2',
                              hourly_wage: 37, weekly_hours: 13, expected_conclusion: 1.month.from_now,
                              project: desafios, freelancer: spongebob, contractor: peter)

      proposal2.valid?

      expect(proposal2.errors.full_messages_for(:freelancer_id)).to include 'Freelancer não pode enviar mais de uma proposta simultânea para mesmo projeto'
    end

    it 'uniqueness does not take into account archived proposals successfull' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                                    social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                                    description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                                    experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
      desafios = Project.create!(title: 'Plataforma de desafios de programação',
                                description: 'Pessoal da Campus Code',
                                desired_skills: 'Esforçada, obstinada e cuidadosa',
                                top_hourly_wage: 67,
                                proposal_deadline: 1.week.from_now,
                                remote: true,
                                contractor: peter,
                                freelancer_expertise: webdev)
      proposal = Proposal.create!(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma',
                              hourly_wage: 32, weekly_hours: 12, expected_conclusion: 5.weeks.from_now,
                              project: desafios, freelancer: spongebob, contractor: peter, archived: true)
      proposal2 = Proposal.new(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma2',
                              hourly_wage: 37, weekly_hours: 13, expected_conclusion: 56.weeks.from_now,
                              project: desafios, freelancer: spongebob, contractor: peter)

      proposal2.valid?

      expect(proposal2.errors.full_messages_for(:freelancer_id)).not_to include 'Freelancer não pode enviar mais de uma proposta simultânea para mesmo projeto'
    end
  end

  context 'custom validation on wage' do
    it "higher border successfully" do
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
    it "equality successfully" do
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
                                  hourly_wage: 37, weekly_hours: 12, expected_conclusion: '10/01/2022',
                                  project: desafios, freelancer: spongebob)

      proposal.valid?

      expect(proposal.errors.full_messages_for(:hourly_wage)).to include 'Valor/hora não pode exceder o máximo preço por hora do projeto'
    end

    it "higher by a decimal successfully" do
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
                                  hourly_wage: 37.01, weekly_hours: 12, expected_conclusion: '10/01/2022',
                                  project: desafios, freelancer: spongebob)

      proposal.valid?
      
      expect(proposal.errors.full_messages_for(:hourly_wage)).to include 'Valor/hora não pode exceder o máximo preço por hora do projeto'
    end
  end

  context 'custom validation on expected conclusion' do
    it 'cannot be in the past' do
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
                                  hourly_wage: 37.01, weekly_hours: 12, expected_conclusion: 1.day.ago,
                                  project: desafios, freelancer: spongebob)

      proposal.valid?

      expect(proposal.errors.full_messages_for(:expected_conclusion)).to include 'Conclusão esperada não pode ser no passado'
    end

    it 'cannot be earlier than projects proposal deadline' do
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
                                proposal_deadline: 5.days.from_now,
                                remote: true,
                                contractor: peter,
                                freelancer_expertise: webdev)
      proposal = Proposal.new(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma',
                                  hourly_wage: 37.01, weekly_hours: 12, expected_conclusion: 4.days.from_now,
                                  project: desafios, freelancer: spongebob)

      proposal.valid?

      expect(proposal.errors.full_messages_for(:expected_conclusion)).to include 'Conclusão esperada não pode ser antes do prazo de submissão final do projeto'
    end
    it 'cannot be on the same day of project proposal deadline' do
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
                                proposal_deadline: 5.days.from_now,
                                remote: true,
                                contractor: peter,
                                freelancer_expertise: webdev)
      proposal = Proposal.new(proposal_description: 'Sou ex-aluno da Campus Code e quero contribuir com a plataforma',
                                  hourly_wage: 37.01, weekly_hours: 12, expected_conclusion: 5.days.from_now,
                                  project: desafios, freelancer: spongebob)

      proposal.valid?

      expect(proposal.errors.full_messages_for(:expected_conclusion)).to include 'Conclusão esperada não pode ser no mesmo dia do prazo de submissão final do projeto'
    end
  end
end