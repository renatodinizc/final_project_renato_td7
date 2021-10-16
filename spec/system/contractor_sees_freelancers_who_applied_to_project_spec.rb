require 'rails_helper'

describe 'Contractor sees freeelancers who applied to project' do
  it 'successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
                              freelancer_expertise: ux)
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                              social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                              description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                              experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
    squidward = Freelancer.create!(email: 'squidward@hub.com', password: '123123', full_name: 'Squidward Tentacles',
                                social_name: 'Squidward', birth_date: '20/04/1973', degree: 'Contabilidade',
                                description: 'Gosto de organização e pontualidade nos meus trabalhos',
                                experience: 'Já trabalhei como contador e caixa no Siri Cascudo', freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    artes = Project.create!(title: 'Artes impressas para palestra',
                            description: 'Campeonato de debates na USP', desired_skills: 'Pessoa criativa e dinâmica',
                            top_hourly_wage: 7, proposal_deadline: '08/06/2021',
                            remote: false, contractor: peter, freelancer_expertise: ux)
    desafios = Project.create!(title: 'Plataforma de desafios de programação', description: 'Pessoal da Campus Code',
                              desired_skills: 'Esforçada, obstinada e cuidadosa', top_hourly_wage: 37,
                              proposal_deadline: '22/01/2022', remote: true, contractor: peter, freelancer_expertise: webdev)
    jane_proposal = Proposal.create!(proposal_description: 'Quero muito contribuir',
                                hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                project: desafios, freelancer: jane)
    spongebob_proposal1 = Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                                hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                project: website, freelancer: spongebob) 
    spongebob_proposal2 = Proposal.create!(proposal_description: 'De hamburgueres para programação é batata',
                                  hourly_wage: 3, weekly_hours: 1, expected_conclusion: '14/05/2022',
                                  project: desafios, freelancer: spongebob)

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Plataforma de desafios de programação'

    expect(page).to have_content 'Propostas recebidas'
    expect(page).to have_link 'Jane'
    expect(page).to have_content 'Descrição do profissional: Preciso de um freela'
    expect(page).to have_content 'Justificativa para o projeto: Quero muito contribuir'
    expect(page).to have_content 'Preço/hora: R$ 14,00'
    expect(page).to have_link 'Sponge Bob'
    expect(page).to have_content 'Descrição do profissional: Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos '
    expect(page).to have_content 'Justificativa para o projeto: De hamburgueres para programação é batata'
    expect(page).to have_content 'Preço/hora: R$ 3,00'
    expect(page).not_to have_link 'Squidward'
    expect(page).not_to have_content 'Descrição do profissional: Gosto de organização e pontualidade nos meus trabalhos'
  end

  it 'and access profile successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
                              freelancer_expertise: ux)
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                              social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                              description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                              experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
    squidward = Freelancer.create!(email: 'squidward@hub.com', password: '123123', full_name: 'Squidward Tentacles',
                                social_name: 'Squidward', birth_date: '20/04/1973', degree: 'Contabilidade',
                                description: 'Gosto de organização e pontualidade nos meus trabalhos',
                                experience: 'Já trabalhei como contador e caixa no Siri Cascudo', freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    artes = Project.create!(title: 'Artes impressas para palestra',
                            description: 'Campeonato de debates na USP', desired_skills: 'Pessoa criativa e dinâmica',
                            top_hourly_wage: 7, proposal_deadline: '08/06/2021',
                            remote: false, contractor: peter, freelancer_expertise: ux)
    desafios = Project.create!(title: 'Plataforma de desafios de programação', description: 'Pessoal da Campus Code',
                              desired_skills: 'Esforçada, obstinada e cuidadosa', top_hourly_wage: 37,
                              proposal_deadline: '22/01/2022', remote: true, contractor: peter, freelancer_expertise: webdev)
    jane_proposal = Proposal.create!(proposal_description: 'Quero muito contribuir',
                                hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                project: desafios, freelancer: jane)
    spongebob_proposal1 = Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                                hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                project: website, freelancer: spongebob) 
    spongebob_proposal2 = Proposal.create!(proposal_description: 'De hamburgueres para programação é batata',
                                  hourly_wage: 3, weekly_hours: 1, expected_conclusion: '14/05/2022',
                                  project: desafios, freelancer: spongebob)

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Plataforma de desafios de programação'
    click_on 'Sponge Bob'

    expect(page).to have_content 'Perfil do freelancer spongebob@hub.com'
    expect(page).to have_content 'Nome completo: Sponge Bob SquarePants'
    expect(page).not_to have_content 'janedoe@hub.com'
    expect(page).not_to have_content 'Nome completo: Jane Doe'
  end
end