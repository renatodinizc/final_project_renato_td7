require 'rails_helper'

describe 'Freelancer cancels proposal while it pends for approval' do
  it 'successfully' do
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
                                project: website, freelancer: spongebob)

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
end