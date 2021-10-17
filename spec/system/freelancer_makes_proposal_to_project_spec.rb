require 'rails_helper'

describe 'Freelancer makes proposal to project' do
  it 'successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
                              freelancer_expertise: webdev)
    Project.create!(title: 'Plataforma de desafios de programação',
                    description: 'Pessoal da Campus Code',
                    desired_skills: 'Esforçada, obstinada e cuidadosa',
                    top_hourly_wage: 37,
                    proposal_deadline: '22/01/2022',
                    remote: true,
                    contractor: peter,
                    freelancer_expertise: webdev)

    login_as jane, scope: :freelancer
    visit root_path
    click_on 'Plataforma de desafios de programação'
    fill_in 'Justificativa', with: 'Fui aluno da turma 7 do TreinaDev e quero contribuir com o projeto'
    fill_in 'Valor/hora', with: 14
    fill_in 'Horas semanais', with: 20
    fill_in 'Conclusão esperada', with: '30/01/2022'
    click_on 'Enviar proposta'

    expect(page).to have_content 'Plataforma de desafios de programação'
    expect(page).to have_content 'Suas propostas:'
    expect(page).to have_content 'Justificativa: Fui aluno da turma 7 do TreinaDev e quero contribuir com o projeto'
    expect(page).to have_content 'Valor/hora: R$ 14,00'
    expect(page).to have_content 'Carga horária semanal: 20 horas'
    expect(page).to have_content 'Conclusão esperada: 30/01/2022'
    expect(page).to have_content 'Status da proposta: Aprovação pendente'

  end

  it 'and access it through My projects menu' do
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    designer = FreelancerExpertise.create!(title: 'Designer')
    jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
                              freelancer_expertise: webdev)
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')                                 
    website = Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 78,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: peter,
                    freelancer_expertise: webdev)
    artes = Project.create!(title: 'Artes impressas para palestra',
                    description: 'Campeonato de debates na USP',
                    desired_skills: 'Pessoa criativa e dinâmica',
                    top_hourly_wage: 90,
                    proposal_deadline: '08/06/2021',
                    remote: false,
                    contractor: peter,
                    freelancer_expertise: designer)
    desafios = Project.create!(title: 'Plataforma de desafios de programação',
                    description: 'Pessoal da Campus Code',
                    desired_skills: 'Esforçada, obstinada e cuidadosa',
                    top_hourly_wage: 93,
                    proposal_deadline: '22/01/2022',
                    remote: true,
                    contractor: peter,
                    freelancer_expertise: webdev)
    jane_proposal1 = Proposal.create!(proposal_description: 'Quero muito contribuir',
                                      hourly_wage:76 , weekly_hours: 7, expected_conclusion: '22/01/2022',
                                      project: website, freelancer: jane)
    jane_proposal2 = Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                                      hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                      project: desafios, freelancer: jane) 

    login_as jane, scope: :freelancer                                 
    visit root_path
    click_on 'Meus projetos'

    expect(page).to have_content 'Meus projetos:'
    expect(page).to have_link 'Website para grupo de estudos'
    expect(page).to have_content 'Descrição: Grupo de estudos liberal de Salvador'
    expect(page).to have_link 'Plataforma de desafios de programação'
    expect(page).to have_content 'Descrição: Pessoal da Campus Code'
    expect(page).not_to have_link 'Artes impressas para palestra'
    expect(page).not_to have_content 'Campeonato de debates na USP'
  end
end