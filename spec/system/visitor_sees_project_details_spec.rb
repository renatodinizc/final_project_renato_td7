require 'rails_helper'

describe 'Visitor sees project details' do
  it 'successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo)

    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).to have_css('h1', text: 'Website para grupo de estudos')
    expect(page).to have_content('Grupo de estudos liberal de Salvador')
    expect(page).to have_content('O que procuramos no freela: Orientado a prazos e qualidade')
    expect(page).to have_content('Máximo preço por hora: R$ 10,00')
    expect(page).to have_content('Data limite para envio de propostas: 10/12/2021')
    expect(page).to have_content('Trabalho remoto: sim')
  end
  it 'and comes back to see another project details successfully' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo)
    Project.create!(title: 'Artes impressas para palestra',
                    description: 'Campeonato de debates na USP',
                    desired_skills: 'Pessoa criativa e dinâmica',
                    top_hourly_wage: 7,
                    proposal_deadline: '08/06/2021',
                    remote: false,
                    contractor: foo)

    visit root_path
    click_on 'Website para grupo de estudos'
    click_on 'Voltar'
    click_on 'Artes impressas para palestra'

    expect(page).to have_css('h1', text: 'Artes impressas para palestra')
    expect(page).to have_content('Campeonato de debates na USP')
    expect(page).to have_content('O que procuramos no freela: Pessoa criativa e dinâmica')
    expect(page).to have_content('Máximo preço por hora: R$ 7,00')
    expect(page).to have_content('Data limite para envio de propostas: 08/06/2021')
    expect(page).to have_content('Trabalho remoto: não')
    end
end