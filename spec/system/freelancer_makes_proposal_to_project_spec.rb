require 'rails_helper'

describe 'Freelancer makes proposal to project' do
  it 'successfully' do
    jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
      social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
      description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    Project.create!(title: 'Plataforma de desafios de programação',
      description: 'Pessoal da Campus Code',
      desired_skills: 'Esforçada, obstinada e cuidadosa',
      top_hourly_wage: 37,
      proposal_deadline: '22/01/2022',
      remote: true,
      contractor: peter)

    login_as jane, scope: :freelancer
    visit root_path
    click_on 'Plataforma de desafios de programação'
    fill_in 'Justificativa', with: 'Fui aluno da turma 7 do TreinaDev e quero contribuir com o projeto'
    fill_in 'Valor/hora', with: 14
    fill_in 'Horas semanais', with: 20
    fill_in 'Conclusão esperada', with: '30/01/2022'
    click_on 'Enviar proposta'

    expect(page).to have_content 'Plataforma de desafios de programação'
    expect(page).to have_content 'Proposta enviada com sucesso!'
    expect(page).to have_content 'Suas propostas enviadas'
    expect(page).to have_content 'Status da proposta: Pendente'
  end
end