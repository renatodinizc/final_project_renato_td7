require 'rails_helper'

describe 'Freelancer logs' do
  context 'into platform ' do
    it 'successfully' do
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')

      visit root_path
      click_on 'Entrar como freelancer'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Senha', with: '123123'
      click_on 'Log in'

      expect(page).to have_content 'foo@bar.com'
      expect(page).to have_content 'Sair da conta'
      expect(page).not_to have_content 'Entrar como freelancer'
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
  end
end
