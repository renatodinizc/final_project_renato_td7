require 'rails_helper'


describe 'Freelancer views project team' do
  it 'successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123', full_name: 'Sandra Jennifer Cheeks',
                              social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Vim da superfície para viver aqui', experience: 'Sou bastante esforçada e dedicada',
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
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 97,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    sandy_proposal = Proposal.create!(proposal_description: 'Me divirto trabalhando e realizando projetos novos',
                                      hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                                      project: website, freelancer: sandy, contractor: peter, status: 'proposal_approved')
    squidward_proposal = Proposal.create!(proposal_description: 'Achei o projeto interessante por isso resolvi aplicar',
                                          hourly_wage: 29, weekly_hours: 17, expected_conclusion: '27/02/2022',
                                          project: website, freelancer: squidward, contractor: peter)
    spongebob_proposal = Proposal.create!(proposal_description: 'Quero ganhar experiência com projetos na área',
                                          hourly_wage: 25, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                          project: website, freelancer: spongebob, contractor: peter, status: 'proposal_approved')

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).to have_content 'Nome social: Sandy'
    expect(page).to have_content 'Descrição do profissional: Vim da superfície para viver aqui'
    expect(page).to have_content 'Justificativa para o projeto: Me divirto trabalhando e realizando projetos novos'
    expect(page).to have_content 'Nome social: Sponge Bob'
    expect(page).to have_content 'Descrição do profissional: Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos'
    expect(page).to have_content 'Justificativa para o projeto: Quero ganhar experiência com projetos na área'
    expect(page).not_to have_content 'Nome social: Squidward'
    expect(page).not_to have_content 'Descrição do profissional: Gosto de organização e pontualidade nos meus trabalhos'
    expect(page).not_to have_content 'Justificativa para o projeto: Achei o projeto interessante por isso resolvi aplicar'

  end
end