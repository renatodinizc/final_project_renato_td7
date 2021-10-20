require 'rails_helper'

describe 'Freelancer fails to see proposals from others' do
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
    desafios = Project.create!(title: 'Plataforma de desafios de programação', description: 'Pessoal da Campus Code',
                              desired_skills: 'Esforçada, obstinada e cuidadosa', top_hourly_wage: 37,
                              proposal_deadline: '22/01/2022', remote: true, contractor: peter, freelancer_expertise: webdev)
    jane_proposal = Proposal.create!(proposal_description: 'Quero muito contribuir',
                                hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                project: desafios, freelancer: jane, contractor: peter)
    spongebob_proposal2 = Proposal.create!(proposal_description: 'De hamburgueres para programação é batata',
                                  hourly_wage: 3, weekly_hours: 6, expected_conclusion: '14/05/2022',
                                  project: desafios, freelancer: spongebob, contractor: peter)

    login_as squidward, scope: :freelancer
    visit root_path
    click_on 'Plataforma de desafios de programação'

    expect(page).not_to have_content 'Justificativa: Quero muito contribuir'
    expect(page).not_to have_content 'Carga horária semanal: 7 horas'
    expect(page).not_to have_content 'De hamburgueres para programação é batata'
    expect(page).not_to have_content 'Carga horária semanal: 6 horas'

  end
end