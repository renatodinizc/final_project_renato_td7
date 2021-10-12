require 'rails_helper'


describe 'Freelancer is redirected to profile form while has incomplete information' do
  it 'successfully' do
    foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')

    visit root_path
    click_on 'Entrar como freelancer'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '123123'
    click_on 'Log in'

    expect(page).to have_css('h1', text: 'Formulário de cadastro de perfil pessoal')
    expect(page).to have_link 'Atualizar perfil'
    expect(page).not_to have_content 'Bem vindo ao FreelancingHUB'
    
  end
end