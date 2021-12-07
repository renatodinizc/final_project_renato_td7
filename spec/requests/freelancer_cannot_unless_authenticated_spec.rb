require 'rails_helper'

describe 'Freelancer cannot,' do
  context 'unless authenticated,' do
    it 'brute create new project proposal' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      # webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      webdev = create(:freelancer_expertise, title: 'Desenvolvedor web')
      Project.create!(title: 'Website para grupo de estudos',
                      description: 'Grupo de estudos liberal de Salvador',
                      desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                      proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                      freelancer_expertise: webdev)

      post '/projects/1/proposals'

      expect(response).to redirect_to(new_freelancer_session_path)
    end

    it 'archive project proposal' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                                 full_name: 'Sandra Jennifer Cheeks',
                                 social_name: 'Sandy', birth_date: '20/04/1990',
                                 degree: 'Engenharia',
                                 description: 'Vim da superfície para viver aqui',
                                 experience: 'Sou bastante esforçada e dedicada',
                                 freelancer_expertise: webdev)
      website = Project.create!(title: 'Website para grupo de estudos',
                                description: 'Grupo de estudos liberal de Salvador',
                                desired_skills: 'Orientado a prazos e qualidade',
                                top_hourly_wage: 60,
                                proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                                freelancer_expertise: webdev)
      Proposal.create!(proposal_description: 'Me divirto trabalhando e realizando projetos novos',
                       hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                       project: website, freelancer: sandy, contractor: peter)

      post '/proposals/1/archive'

      expect(response).to redirect_to(new_freelancer_session_path)
    end

    it 'access any freelancer profile (including oneself)' do
      Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                         full_name: 'Sandra Jennifer Cheeks',
                         social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                         description: 'Vim da superfície para viver aqui',
                         experience: 'Sou bastante esforçada e dedicada',
                         freelancer_expertise: webdev)

      get '/freelancers/1'

      expect(response).to redirect_to(new_freelancer_session_path)
    end

    it 'edit own profile' do
      Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                         full_name: 'Sandra Jennifer Cheeks',
                         social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                         description: 'Vim da superfície para viver aqui',
                         experience: 'Sou bastante esforçada e dedicada',
                         freelancer_expertise: webdev)

      get '/freelancers/1/edit'

      expect(response).to redirect_to(new_freelancer_session_path)
    end

    it 'search project in platform' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                         full_name: 'Sandra Jennifer Cheeks',
                         social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                         description: 'Vim da superfície para viver aqui',
                         experience: 'Sou bastante esforçada e dedicada',
                         freelancer_expertise: webdev)
      Project.create!(title: 'Website para grupo de estudos',
                      description: 'Grupo de estudos liberal de Salvador',
                      desired_skills: 'Orientado a prazos e qualidade',
                      top_hourly_wage: 60,
                      proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                      freelancer_expertise: webdev)

      get '/projects/search?search='

      expect(response).to redirect_to(new_freelancer_session_path)
    end

    it 'access chat of accepted proposal' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                                 full_name: 'Sandra Jennifer Cheeks',
                                 social_name: 'Sandy', birth_date: '20/04/1990',
                                 degree: 'Engenharia',
                                 description: 'Vim da superfície para viver aqui',
                                 experience: 'Sou bastante esforçada e dedicada',
                                 freelancer_expertise: webdev)
      website = Project.create!(title: 'Website para grupo de estudos',
                                description: 'Grupo de estudos liberal de Salvador',
                                desired_skills: 'Orientado a prazos e qualidade',
                                top_hourly_wage: 10,
                                proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                                freelancer_expertise: webdev)
      Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                       hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                       project: website, freelancer: sandy, contractor: peter,
                       status: 'proposal_approved')

      get '/proposals/1'

      expect(response).to redirect_to(new_freelancer_session_path)
    end

    it 'forfeit a project proposal' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                                 full_name: 'Sandra Jennifer Cheeks',
                                 social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                                 description: 'Vim da superfície para viver aqui',
                                 experience: 'Sou bastante esforçada e dedicada',
                                 freelancer_expertise: webdev)
      website = Project.create!(title: 'Website para grupo de estudos',
                                description: 'Grupo de estudos liberal de Salvador',
                                desired_skills: 'Orientado a prazos e qualidade',
                                top_hourly_wage: 60,
                                proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                                freelancer_expertise: webdev)
      Proposal.create!(proposal_description: 'Me divirto trabalhando e realizando projetos novos',
                       hourly_wage: 14, weekly_hours: 7,
                       expected_conclusion: '22/01/2022',
                       project: website, freelancer: sandy, contractor: peter)

      post '/proposals/1/forfeit'

      expect(response).to redirect_to(new_freelancer_session_path)
    end
  end

  context 'even authenticated,' do
    it 'access another freelancer profile' do
      Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123',
                                 full_name: 'Sandra Jennifer Cheeks',
                                 social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                                 description: 'Vim da superfície para viver aqui',
                                 experience: 'Sou bastante esforçada e dedicada',
                                 freelancer_expertise: webdev)
      Freelancer.create!(email: 'spongebob@hub.com', password: '123123',
                         full_name: 'Sponge Bob SquarePants',
                         social_name: 'Sponge Bob', birth_date: '14/07/1986',
                         degree: 'Cooking',
                         description: 'Já trabalhei em águas internacionais',
                         experience: 'Já trabalhei como chef no Siri Cascudo',
                         freelancer_expertise: webdev)

      login_as sandy, scope: :freelancer
      get '/freelancers/2'

      expect(response).to redirect_to(freelancer_path(sandy))
    end
  end
end
