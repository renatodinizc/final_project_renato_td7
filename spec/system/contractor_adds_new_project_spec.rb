require 'rails_helper'

describe 'Contractor adds new project to website' do
  it 'successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    FreelancerExpertise.create!(title: 'Desenvolvedor web')
    FreelancerExpertise.create!(title: 'Designer')
    FreelancerExpertise.create!(title: 'UX')


    login_as foo, scope: :contractor
    visit root_path
    click_on 'Cadastrar novo projeto'
    fill_in 'Título', with: 'Website para grupo de estudos'
    fill_in 'Descrição', with: 'Grupo de estudos liberal de Salvador'
    fill_in 'Habilidades preferenciais', with: 'Orientado a prazos e qualidade'
    fill_in 'Máximo preço por hora', with: 10
    fill_in 'Prazo de submissão final', with: '10/12/2021'
    check 'Remoto'
    select 'Desenvolvedor web', from: 'Área de atuação'
    click_on 'Salvar Projeto'

    expect(page).to have_css('h1', text: 'Website para grupo de estudos')
    expect(page).to have_content('Grupo de estudos liberal de Salvador')
    expect(page).to have_content('O que procuramos no freela: Orientado a prazos e qualidade')
    expect(page).to have_content('Máximo preço por hora: R$ 10,00')
    expect(page).to have_content('Data limite para envio de propostas: 10/12/2021')
    expect(page).to have_content('Trabalho remoto: sim')
    expect(page).to have_content('Área de atuação requerida: Desenvolvedor web')

  end
  it 'and cannot left it with blank fields' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Cadastrar novo projeto'
    click_on 'Salvar Projeto'

    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Habilidades preferenciais não pode ficar em branco'
    expect(page).to have_content 'Máximo preço por hora não pode ficar em branco'
    expect(page).to have_content 'Prazo de submissão final não pode ficar em branco'
  end
  
  it 'via own profile' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Cadastrar novo projeto'

    expect(page).to have_content 'Página de cadastro de novo projeto'
    expect(page).not_to have_link 'Cadastrar novo projeto'
  end
end
    