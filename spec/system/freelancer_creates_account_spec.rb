require 'rails_helper'

describe 'Freelancer creates account at plataform' do
  it 'successfully' do
    visit root_path
    click_on 'Entrar como freelancer'
    click_on 'Sign up'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Senha', with: '123123'
    fill_in 'Confirmar senha', with: '123123'
    click_on 'Sign up'

    expect(page).to have_content 'Você está logado como freelancer. Email: foo@bar.com'
    expect(page).not_to have_content 'Sign up'
  end
  it 'and confirms password correctly' do
    visit root_path
    click_on 'Entrar como freelancer'
    click_on 'Sign up'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Senha', with: '123123'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Sign up'

    expect(page).not_to have_content 'Você está logado como freelancer. Email: foo@bar.com'
    expect(page).to have_content 'Sign up'
  end
end