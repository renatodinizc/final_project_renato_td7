require 'rails_helper'

describe 'Contractor logs' do
  context 'into plataform' do
    it 'successfully' do
      Contractor.create!(email: 'foo@bar.com', password: '123123')
      visit root_path
      click_on 'Entrar como contratante'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Senha', with: '123123'
      click_on 'Log in'

      expect(page).to have_content 'foo@bar.com'
      expect(page).to have_content 'Sair da conta'
      expect(page).not_to have_content 'Entrar como contratante'
    end

    context 'into own profile'
    it 'successfuly' do
      foo = Contractor.create!(email: 'foo@bar.com', password: '123123')

      login_as foo, scope: :contractor
      visit root_path
      click_on 'Ver meu perfil'

      expect(page).to have_css('h1', text: 'Perfil do contratante foo@bar.com')
      expect(page).not_to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
    end

    it 'and sees all of his own projects succesfully' do
      foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
      bar = Contractor.create!(email: 'bar@foo.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      designer = FreelancerExpertise.create!(title: 'Designer')

      Project.create!(title: 'Website para grupo de estudos',
                      description: 'Grupo de estudos liberal de Salvador',
                      desired_skills: 'Orientado a prazos e qualidade',
                      top_hourly_wage: 10,
                      proposal_deadline: '10/12/2021',
                      remote: true,
                      contractor: foo,
                      freelancer_expertise: webdev)
      Project.create!(title: 'Artes impressas para palestra',
                      description: 'Campeonato de debates na USP',
                      desired_skills: 'Pessoa criativa e dinâmica',
                      top_hourly_wage: 7,
                      proposal_deadline: '08/06/2021',
                      remote: false,
                      contractor: foo,
                      freelancer_expertise: designer)
      Project.create!(title: 'Plataforma de desafios de programação',
                      description: 'Pessoal da Campus Code',
                      desired_skills: 'Esforçada, obstinada e cuidadosa',
                      top_hourly_wage: 37,
                      proposal_deadline: '22/01/2022',
                      remote: true,
                      contractor: bar,
                      freelancer_expertise: webdev)

      login_as foo, scope: :contractor
      visit root_path
      click_on 'Ver meu perfil'

      expect(page).to have_css('h3', text: 'Meus projetos:')
      expect(page).to have_content('Website para grupo de estudos')
      expect(page).to have_content('Artes impressas para palestra')
      expect(page).not_to have_content('Plataforma de desafios de programação')
    end
  end
end
