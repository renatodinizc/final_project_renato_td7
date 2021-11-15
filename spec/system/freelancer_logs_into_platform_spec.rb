require 'rails_helper'

describe 'Freelancer logs' do
  context 'into platform' do
    it 'successfully' do
      create(:freelancer, email: 'spongebob@hub.com', password: '123123')

      visit root_path
      click_on 'Entrar como freelancer'
      fill_in 'Email', with: 'spongebob@hub.com'
      fill_in 'Senha', with: '123123'
      click_on 'Log in'
      visit root_path

      expect(page).to have_content 'spongebob@hub.com'
      expect(page).to have_content 'Sair da conta'
      expect(page).not_to have_content 'Entrar como freelancer'
    end

    it 'and sees all avaiable projects successfully' do
      spongebob = create(:freelancer)
      create(:project, title: 'Website para grupo de estudos')
      create(:project, title: 'Artes impressas para palestra')
      create(:project, title: 'Plataforma de desafios de programação')

      login_as spongebob, scope: :freelancer
      visit root_path

      expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
      expect(page).to have_link 'Website para grupo de estudos'
      expect(page).to have_link 'Artes impressas para palestra'
      expect(page).to have_link 'Plataforma de desafios de programação'
    end
    it 'and sees message if there are no projects avaiable successfully' do
      spongebob = create(:freelancer)
      
      login_as spongebob, scope: :freelancer
      visit root_path

      expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
      expect(page).to have_content 'Ainda não existem projetos cadastrados'
    end
    
    it 'and searches for specific project by its title successfully' do
      spongebob = create(:freelancer)
      create(:project, title: 'Website para grupo de estudos')
      create(:project, title: 'Artes impressas para palestra')
      create(:project, title: 'Plataforma de desafios de programação') 

      login_as spongebob, scope: :freelancer
      visit root_path
      fill_in 'Procurar projeto', with: 'Website' 
      click_on 'Procurar projeto'

      expect(page).to have_content 'Website para grupo de estudos'
      expect(page).not_to have_content 'Artes impressas para palestra'
      expect(page).not_to have_content 'Plataforma de desafios de programação'
    end

    it 'and searches for specific project by its description sucessfully' do
      spongebob = create(:freelancer)
      create(:project, title: 'Website para grupo de estudos',
            description: 'Grupo de estudos liberal de Salvador')
      create(:project, title: 'Artes impressas para palestra',
            description: 'Campeonato de debates na USP' )
      create(:project, title: 'Plataforma de desafios de programação',
            description: 'Pessoal da Campus Code') 

      login_as spongebob, scope: :freelancer
      visit root_path
      fill_in 'Procurar projeto', with: 'USP' 
      click_on 'Procurar projeto'

      expect(page).to have_link 'Artes impressas para palestra'
      expect(page).not_to have_link 'Website para grupo de estudos'
      expect(page).not_to have_link 'Plataforma de desafios de programação'
    end
  end

  context 'into own profile' do
    it 'successfully' do
      spongebob = create(:freelancer, email: 'spongebob@hub.com')

      login_as spongebob, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'

      expect(page).to have_css('h1', text: 'Perfil do freelancer spongebob@hub.com')
      expect(page).not_to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
    end

    it 'and edits own information successfully' do
      webdev = create(:freelancer_expertise, title: 'Desenvolvedor web')
      create(:freelancer_expertise, title: 'UX')
      spongebob = create(:freelancer, email: 'spongebob@hub.com', password: '123123',
                        full_name: 'Sponge Bob SquarePants', social_name: 'Sponge Bob',
                        birth_date: '20/04/1990', degree: 'Engenharia', description: 'Preciso de um freela',
                        experience: 'Já trabalhei em muitos projetos', freelancer_expertise: webdev)

      login_as spongebob, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'
      click_on 'Editar meu perfil'
      fill_in 'Nome completo', with: 'Sponge Bob SquarePants 2'
      fill_in 'Nome social', with: 'Sponge Bob 2'
      fill_in 'Data de nascimento', with: '01/01/1950'
      select 'UX', from: 'Área de atuação'
      fill_in 'Formação profissional', with: 'Economia'
      fill_in 'Descrição', with: 'Preciso de um freela 2'
      fill_in 'Experiência', with: 'Já trabalhei em muitos projetos 2'
      click_on 'Salvar Freelancer'

      expect(page).to have_content 'Nome completo: Sponge Bob SquarePants 2'
      expect(page).to have_content 'Nome social: Sponge Bob 2'
      expect(page).to have_content 'Data de nascimento: 01/01/1950'
      expect(page).to have_content 'Área de atuação: UX'
      expect(page).to have_content 'Formação profissional: Economia'
      expect(page).to have_content 'Descrição: Preciso de um freela 2'
      expect(page).to have_content 'Experiência: Já trabalhei em muitos projetos 2'
    end

    it 'and comes back to homepage successfully' do
      spongebob = create(:freelancer, email: 'spongebob@hub.com')

      login_as spongebob, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'
      click_on 'Voltar para homepage'

      expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
      expect(page).not_to have_content 'Perfil do freelancer spongebob@hub.com'
    end
  end
end
