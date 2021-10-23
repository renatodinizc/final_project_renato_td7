require 'rails_helper'

describe 'Contractor changes status of proposal' do
  it 'to approved successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
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

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    click_on 'Aprovar proposta'

    expect(page).to have_content 'Status da proposta: Aprovada'

  end

  it 'to denied successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
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

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    click_on 'Recusar proposta'
    fill_in 'Motivo', with: 'Muito obrigado pela oferta, mas o tempo hábil de finalização do projeto não é o ideal'
    click_on 'Enviar feedback'

    expect(page).to have_content 'Status da proposta: Recusada'
    expect(page).to have_content 'Motivo: Muito obrigado pela oferta, mas o tempo hábil de finalização do projeto não é o ideal'
    expect(page).not_to have_link 'Recusar proposta'
  end

  it 'to denied with empty feedback unssuccessfuly' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
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

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    click_on 'Recusar proposta'
    fill_in 'Motivo', with: ''
    click_on 'Enviar feedback'

    expect(page).not_to have_content 'Status da proposta: Recusada'
    expect(page).to have_content 'Feedback sobre recusa de proposta'
    expect(page).to have_content 'Motivo não pode ficar em branco'
    expect(page).to have_button 'Enviar feedback'
  end

  it 'to denied with short feedback unsuccessfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
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

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    click_on 'Recusar proposta'
    fill_in 'Motivo', with: 'Não'
    click_on 'Enviar feedback'

    expect(page).not_to have_content 'Status da proposta: Recusada'
    expect(page).to have_content 'Feedback sobre recusa de proposta'
    expect(page).to have_content 'Motivo é muito curto (mínimo: 10 caracteres)'
    expect(page).to have_button 'Enviar feedback'
  end

end