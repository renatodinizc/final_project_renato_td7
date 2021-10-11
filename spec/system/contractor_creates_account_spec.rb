require 'rails_helper'

describe 'Contractor creates account at plataform' do
  it 'successfully' do
    visit root_path
    click_on 'Entrar como contratante'
    click_on 'Sign up'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '123123'
    fill_in 'Password confirmation', with: '123123'
    click_on 'Sign up'

    expect(page).to have_content 'Você é um Contratante! Seu email é: foo@bar.com'
    expect(page).not_to have_content 'Sign up'
  end
  it 'and confirms password correctly' do
    visit root_path
    click_on 'Entrar como contratante'
    click_on 'Sign up'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '123123'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).not_to have_content 'Você é um Contratante! Seu email é: foo@bar.com'
    expect(page).to have_content 'Sign up'
  end
end