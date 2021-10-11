describe 'rails_helper'

describe 'Freelancer logs' do
  context 'into platform ' do
    it 'successfully' do
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')

      visit root_path
      click_on 'Entrar como freelancer'
      fill_in 'Email', with: 'foo@bar.com'
      fill_in 'Password', with: '123123'
      click_on 'Log in'

      expect(page).to have_content 'foo@bar.com'
      expect(page).to have_content 'Sair da conta'
      expect(page).not_to have_content 'Entrar como freelancer'
    end
  end

  context 'into own profile' do
    it 'successfuly' do
      foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')

      login_as foo, scope: :freelancer
      visit root_path
      click_on 'Ver meu perfil'

      expect(page).to have_css('h1', text: 'Perfil do Freelancer foo@bar.com')
      expect(page).not_to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
    end
  end
end
