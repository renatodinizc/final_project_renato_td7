require 'rails_helper'

describe 'Freelancer is redirected to profile form when logs in' do
  it 'successfully' do
    Freelancer.create!(email: 'foo@bar.com', password: '123123')

    visit root_path
    click_on 'Entrar como freelancer'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Senha', with: '123123'
    click_on 'Log in'
    visit current_path

    # expect(page).to have_content('Login efetuado com sucesso!')
    expect(page).to have_content('Você está logado como freelancer')
    expect(page).to have_css('h1', text: 'Formulário de cadastro de perfil pessoal')
    expect(page).to have_content('Nome completo')
    expect(page).to have_button 'Salvar Freelancer'
    expect(page).not_to have_button 'Log in'
    expect(page).not_to have_content 'Bem vindo ao FreelancingHUB'
  end

  it 'completes it and access own profile' do
    Freelancer.create!(email: 'foo@bar.com', password: '123123')
    FreelancerExpertise.create!(title: 'Desenvolvedor web')

    visit root_path
    click_on 'Entrar como freelancer'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Senha', with: '123123'
    click_on 'Log in'
    visit current_path
    fill_in 'Nome completo', with: 'Foo Bar'
    fill_in 'Nome social', with: 'Foo'
    fill_in 'Data de nascimento', with: '20/04/1990'
    select 'Desenvolvedor web', from: 'Área de atuação'
    fill_in 'Formação profissional', with: 'Engenharia'
    fill_in 'Descrição', with: 'Preciso de um freela'
    fill_in 'Experiência', with: 'Já trabalhei em muitos projetos'
    click_on 'Salvar Freelancer'

    expect(page).to have_css('h1', text: 'Perfil do freelancer foo@bar.com')
    expect(page).to have_content 'Nome completo: Foo Bar'
    expect(page).to have_content 'Nome social: Foo'
    expect(page).to have_content 'Data de nascimento: 20/04/1990'
    expect(page).to have_content 'Área de atuação: Desenvolvedor web'
    expect(page).to have_content 'Formação profissional: Engenharia'
    expect(page).to have_content 'Descrição: Preciso de um freela'
    expect(page).to have_content 'Experiência: Já trabalhei em muitos projetos'
  end
end
