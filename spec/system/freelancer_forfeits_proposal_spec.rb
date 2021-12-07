require 'rails_helper'

describe 'Freelancer forfeits proposal' do
  it 'while it pends for approval successfully' do
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

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Meus projetos'
    click_on 'Website para grupo de estudos'
    click_on 'Desistir de proposta'

    expect(page).not_to have_content 'Justificativa: Quero ajudar a construir a liberdade'
    expect(page).not_to have_content 'Valor/hora: R$ 10,00'
    expect(page).not_to have_content 'Carga horária semanal: 10 horas'
    expect(page).not_to have_content 'Conclusão esperada: 10/01/2022'
    expect(page).not_to have_content 'Status da proposta: Pendente'
    expect(page).not_to have_link 'Desistir de proposta'
  end

  it 'within three days after been approved successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
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
                              proposal_deadline: 10.days.from_now, remote: true, contractor: peter,
                              freelancer_expertise: webdev)
    Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                     hourly_wage: 8, weekly_hours: 10,
                     expected_conclusion: 20.days.from_now,
                     project: website, freelancer: spongebob, contractor: peter,
                     status: 'proposal_approved', created_at: 1.day.ago)

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Meus projetos'
    click_on 'Website para grupo de estudos'
    click_on 'Desistir de proposta'
    fill_in 'Motivo', with: 'Encontrei outro projeto mais interessante para o momento'
    click_on 'Enviar feedback'

    expect(page).to have_content 'Justificativa: Quero ajudar a construir a liberdade'
    expect(page).to have_content 'Valor/hora: R$ 8,00'
    expect(page).to have_content 'Status da proposta: Desistência'
    expect(page).not_to have_link 'Desistir de proposta'
  end

  it 'after three days of been approved unsuccessfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
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
                              proposal_deadline: 10.days.from_now, remote: true, contractor: peter,
                              freelancer_expertise: webdev)
    Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                     hourly_wage: 8, weekly_hours: 10,
                     expected_conclusion: 20.days.from_now,
                     project: website, freelancer: spongebob, contractor: peter,
                     status: 'proposal_approved', updated_at: 4.days.from_now)

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Meus projetos'
    click_on 'Website para grupo de estudos'
    click_on 'Desistir de proposta'

    expect(page).to have_content 'Justificativa: Quero ajudar a construir a liberdade'
    expect(page).to have_content 'Valor/hora: R$ 8,00'
    expect(page).to have_content 'Carga horária semanal: 10 horas'
    expect(page).to have_content 'Status da proposta: Aprovada'
    expect(page).to have_content 'Você não pode desistir de uma proposta que foi aprovada a mais de três dias!'
  end
end
