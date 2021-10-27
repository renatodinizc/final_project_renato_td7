require 'rails_helper'

describe 'Contractor cannot, unless authenticated,' do
  it 'create new project' do
    get '/projects/new'

    expect(response).to redirect_to(new_contractor_session_path)
  end

  it 'brute create new project' do
    post '/projects/'

    expect(response).to redirect_to(new_contractor_session_path)
  end

  it 'edit existing project' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
      desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
      proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)

    get '/projects/1/edit'

    expect(response).to redirect_to(new_contractor_session_path)
    
  end

  it 'delete existing project' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
      desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
      proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)

      delete '/projects/1'

      expect(response).to redirect_to(new_contractor_session_path)
  end

  it 'accept a project proposal' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123', full_name: 'Sandra Jennifer Cheeks',
                              social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Vim da superfície para viver aqui', experience: 'Sou bastante esforçada e dedicada',
                              freelancer_expertise: ux)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 60,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    sandy_proposal = Proposal.create!(proposal_description: 'Me divirto trabalhando e realizando projetos novos',
                                      hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                      project: website, freelancer: sandy, contractor: peter)


    post '/proposals/1/accept'

    expect(response).to redirect_to(new_contractor_session_path)
  end

  it 'deny a project proposal' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123', full_name: 'Sandra Jennifer Cheeks',
                              social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Vim da superfície para viver aqui', experience: 'Sou bastante esforçada e dedicada',
                              freelancer_expertise: ux)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 60,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    sandy_proposal = Proposal.create!(proposal_description: 'Me divirto trabalhando e realizando projetos novos',
                                      hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                      project: website, freelancer: sandy, contractor: peter)


    post '/proposals/1/deny'

    expect(response).to redirect_to(new_contractor_session_path)
  end

  it 'access freelancer profile' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123', full_name: 'Sandra Jennifer Cheeks',
                              social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Vim da superfície para viver aqui', experience: 'Sou bastante esforçada e dedicada',
                              freelancer_expertise: ux)
    
    get '/freelancers/1'

    expect(response).to redirect_to(new_contractor_session_path).or redirect_to(new_freelancer_session_path)
  end

  it 'search project in platform' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 60,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)

    get '/projects/search?search='

    expect(response).to redirect_to(new_contractor_session_path).or redirect_to(new_freelancer_session_path)
  end

  it 'access chat of accepted proposal' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                              social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                              description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                              experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    proposal = Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                                hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                project: website, freelancer: spongebob, contractor: peter, status: 'proposal_approved')

    get '/proposals/1'

    expect(response).to redirect_to(new_contractor_session_path).or redirect_to(new_freelancer_session_path)
  end

  it 'create feedback for a propose denial' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                              social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                              description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                              experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    proposal = Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                                hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                project: website, freelancer: spongebob, contractor: peter)

    get '/proposals/1/feedback/new'

    expect(response).to redirect_to(new_contractor_session_path).or redirect_to(new_freelancer_session_path)
  end
end