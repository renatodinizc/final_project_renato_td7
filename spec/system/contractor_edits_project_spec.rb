require 'rails_helper'

describe 'Contractor edits own project' do
  it 'successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    FreelancerExpertise.create!(title: 'UX')

    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo,
                    freelancer_expertise: webdev)

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Website para grupo de estudos'
    click_on 'Editar informações do projeto'
    fill_in 'Título', with: 'Aplicativo para grupo de estudos'
    fill_in 'Descrição', with: 'Grupo de estudos liberal de Recife'
    fill_in 'Habilidades preferenciais', with: 'Orientado a metas e agilidade'
    fill_in 'Máximo preço por hora', with: 12
    fill_in 'Prazo de submissão final', with: '30/12/2021'
    uncheck 'Remoto'
    select 'UX', from: 'Área de atuação'
    click_on 'Salvar Projeto'

    expect(page).to have_css 'h1', text: 'Aplicativo para grupo de estudos'
    expect(page).to have_content 'Grupo de estudos liberal de Recife'
    expect(page).to have_content 'O que procuramos no freela: Orientado a metas e agilidade'
    expect(page).to have_content 'Máximo preço por hora: R$ 12,00'
    expect(page).to have_content 'Data limite para envio de propostas: 30/12/2021'
    expect(page).to have_content 'Trabalho remoto: não'
    expect(page).to have_content 'Área de atuação requerida: UX'
  end

  it 'and comes back to homepage successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    FreelancerExpertise.create!(title: 'UX')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo,
                    freelancer_expertise: webdev)

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Website para grupo de estudos'
    click_on 'Editar informações do projeto'
    fill_in 'Título', with: 'Aplicativo para grupo de estudos'
    fill_in 'Descrição', with: 'Grupo de estudos liberal de Recife'
    fill_in 'Habilidades preferenciais', with: 'Orientado a metas e agilidade'
    fill_in 'Máximo preço por hora', with: 12
    fill_in 'Prazo de submissão final', with: '30/12/2021'
    uncheck 'Remoto'
    select 'UX', from: 'Área de atuação'
    click_on 'Salvar Projeto'
    click_on 'Voltar'

    expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
    expect(page).to have_link('Aplicativo para grupo de estudos')
  end

  it 'and cannot leave any fields empty successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo,
                    freelancer_expertise: webdev)

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Website para grupo de estudos'
    click_on 'Editar informações do projeto'
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Habilidades preferenciais', with: ''
    fill_in 'Máximo preço por hora', with: ''
    fill_in 'Prazo de submissão final', with: ''
    click_on 'Salvar Projeto'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Habilidades preferenciais não pode ficar em branco')
    expect(page).to have_content('Máximo preço por hora não pode ficar em branco')
    expect(page).to have_content('Prazo de submissão final não pode ficar em branco')
  end
end
