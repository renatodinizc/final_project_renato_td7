require 'rails_helper'

describe 'Contractor logs into plataform' do
  it 'successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    visit root_path
    click_on 'Entrar como contratante'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '123123'
    click_on 'Log in'

    expect(page).to have_content 'foo@bar.com'
    expect(page).to have_content 'Sair da conta'
    expect(page).not_to have_content 'Entrar como contratante'
  end

  it 'and sees all of his own projects succesfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    bar = Contractor.create!(email: 'bar@foo.com', password: '123123')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo)
    Project.create!(title: 'Artes impressas para palestra',
                    description: 'Campeonato de debates na USP',
                    desired_skills: 'Pessoa criativa e dinâmica',
                    top_hourly_wage: 7,
                    proposal_deadline: '08/06/2021',
                    remote: false,
                    contractor: foo)
    Project.create!(title: 'Plataforma de desafios de programação',
                    description: 'Pessoal da Campus Code',
                    desired_skills: 'Esforçada, obstinada e cuidadosa',
                    top_hourly_wage: 37,
                    proposal_deadline: '22/01/2022',
                    remote: true,
                    contractor: bar)                
    
    login_as foo, scope: :contractor

    
    visit root_path
    click_on 'Meus projetos'

    expect(page).to have_content('Website para grupo de estudos')
    expect(page).to have_content('Artes impressas para palestra')
    expect(page).not_to have_content('Plataforma de desafios de programação')
  end

end