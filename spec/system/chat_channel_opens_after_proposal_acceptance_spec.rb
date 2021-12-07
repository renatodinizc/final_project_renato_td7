require 'rails_helper'

describe 'Chat channel opens after proposal acceptance' do
  it 'successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    FreelancerExpertise.create!(title: 'UX')
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123',
                                   full_name: 'Sponge Bob SquarePants',
                                   social_name: 'Sponge Bob', birth_date: '14/07/1986',
                                   degree: 'Cooking',
                                   description: 'Já trabalhei em águas internacionais',
                                   experience: 'Já trabalhei como chef no Siri Cascudo',
                                   freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos',
                              description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                              freelancer_expertise: webdev)
    Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                     hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                     project: website, freelancer: spongebob, contractor: peter)

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    click_on 'Aprovar proposta'
    click_on 'Ir para chat'

    expect(page).to have_css 'h1', text: 'Chat entre peterparker@hub.com e Sponge Bob'
  end

  it 'and contractor starts conversation' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    FreelancerExpertise.create!(title: 'UX')
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123',
                                   full_name: 'Sponge Bob SquarePants',
                                   social_name: 'Sponge Bob', birth_date: '14/07/1986',
                                   degree: 'Cooking',
                                   description: 'Já trabalhei em águas internacionais',
                                   experience: 'Já trabalhei como chef no Siri Cascudo',
                                   freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos',
                              description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade',
                              top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                              freelancer_expertise: webdev)
    Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                     hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                     project: website, freelancer: spongebob, contractor: peter)

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    click_on 'Aprovar proposta'
    click_on 'Ir para chat'
    fill_in 'Mensagem', with: 'Hello World!'
    click_on 'Enviar mensagem'

    expect(page).to have_content 'peterparker@hub.com: Hello World'
    expect(page).to have_content 'Nova mensagem:'
    expect(page).to have_button 'Enviar mensagem'
  end

  it 'freelancer starts conversation' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    FreelancerExpertise.create!(title: 'UX')
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123',
                                   full_name: 'Sponge Bob SquarePants',
                                   social_name: 'Sponge Bob', birth_date: '14/07/1986',
                                   degree: 'Cooking',
                                   description: 'Já trabalhei em águas internacionais',
                                   experience: 'Já trabalhei como chef no Siri Cascudo',
                                   freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos',
                              description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                              freelancer_expertise: webdev)
    Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                     hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                     project: website, freelancer: spongebob, contractor: peter, status: 'proposal_approved')

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Meus projetos'
    click_on 'Website para grupo de estudos'
    click_on 'Ir para chat'
    fill_in 'Mensagem', with: 'Hello World!'
    click_on 'Enviar mensagem'

    expect(page).to have_content 'Sponge Bob: Hello World'
    expect(page).to have_content 'Nova mensagem:'
    expect(page).to have_button 'Enviar mensagem'
  end
end
