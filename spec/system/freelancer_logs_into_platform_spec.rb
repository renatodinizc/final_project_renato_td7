require 'rails_helper'

describe 'Freelancer logs' do
  context 'into platform' do
    it 'successfully' do
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')

      visit root_path
      click_on 'Entrar como freelancer'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Senha', with: '123123'
      click_on 'Log in'
      visit root_path

      expect(page).to have_content 'foo@bar.com'
      expect(page).to have_content 'Sair da conta'
      expect(page).not_to have_content 'Entrar como freelancer'
    end

    it 'and sees all avaiable projects successfully' do
      jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')
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

      login_as jane, scope: :freelancer
      visit root_path

      expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
      expect(page).to have_link 'Website para grupo de estudos'
      expect(page).to have_link 'Artes impressas para palestra'
      expect(page).to have_link 'Plataforma de desafios de programação'
    end
    it 'and sees message if there are no projects avaiable' do
      jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
        social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
        description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')

        login_as jane, scope: :freelancer
        visit root_path


        expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
        expect(page).to have_content 'Ainda não existem projetos cadastrados'
    end
    
    it 'and searches for specific project by its title' do
      jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')
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

      login_as jane, scope: :freelancer
      visit root_path
      fill_in 'Procurar projeto', with: 'Website' 
      click_on 'Procurar projeto'

      expect(page).to have_content 'Website para grupo de estudos'
      expect(page).to have_content 'Grupo de estudos liberal de Salvador'
      expect(page).to have_content 'Orientado a prazos e qualidade'
      expect(page).not_to have_content 'Artes impressas para palestra'
      expect(page).not_to have_content 'Plataforma de desafios de programação'
    end

    it 'and searches for specific project by its description' do
      jane = Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                              social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')
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

      login_as jane, scope: :freelancer
      visit root_path
      fill_in 'Procurar projeto', with: 'grupo de estudos' 
      click_on 'Procurar projeto'

      expect(page).to have_content 'Website para grupo de estudos'
      expect(page).to have_content 'Grupo de estudos liberal de Salvador'
      expect(page).to have_content 'Orientado a prazos e qualidade'
      expect(page).not_to have_content 'Artes impressas para palestra'
      expect(page).not_to have_content 'Campeonato de debates na USP'
      expect(page).not_to have_content 'Plataforma de desafios de programação'
      expect(page).not_to have_content 'Pessoal da Campus Code'
    end
  end

  context 'into own profile' do
    it 'successfully' do
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123', full_name: 'Foo Bar',
                              social_name: 'Foo', birth_date: '20/04/1990', degree: 'Engenharia',
                              description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')

      login_as foo, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'

      expect(page).to have_css('h1', text: 'Perfil do freelancer foo@bar.com')
      expect(page).not_to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
    end

    it 'and edits own information' do
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      ux = FreelancerExpertise.create!(title: 'UX')
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123', full_name: 'Foo Bar',
        social_name: 'Foo', birth_date: '20/04/1990', degree: 'Engenharia',
        description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
        freelancer_expertise: webdev)

      login_as foo, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'
      click_on 'Editar meu perfil'
      fill_in 'Nome completo', with: 'Foo Bar2'
      fill_in 'Nome social', with: 'Foo2'
      fill_in 'Data de nascimento', with: '01/01/1950'
      select 'UX', from: 'Área de atuação'
      fill_in 'Formação profissional', with: 'Economia'
      fill_in 'Descrição', with: 'Preciso de um freela2'
      fill_in 'Experiência', with: 'Já trabalhei em muitos projetos2'
      click_on 'Salvar Freelancer'

      expect(page).to have_content 'Nome completo: Foo Bar2'
      expect(page).to have_content 'Nome social: Foo2'
      expect(page).to have_content 'Data de nascimento: 01/01/1950'
      expect(page).to have_content 'Área de atuação: UX'
      expect(page).to have_content 'Formação profissional: Economia'
      expect(page).to have_content 'Descrição: Preciso de um freela2'
      expect(page).to have_content 'Experiência: Já trabalhei em muitos projetos2'
      
    end

    it 'and comes back to homepage successfully' do
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123', full_name: 'Foo Bar',
        social_name: 'Foo', birth_date: '20/04/1990', degree: 'Engenharia',
        description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos')

      login_as foo, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'
      click_on 'Voltar para homepage'

      expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
      expect(page).not_to have_content 'Perfil do freelancer foo@bar.com'
    end
  end
end
