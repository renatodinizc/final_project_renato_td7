require 'rails_helper'

describe 'Visitor sees project details' do
  it 'successfully' do
    create(
      :project,
      title: 'Website para grupo de estudos',
      description: 'Grupo de estudos liberal de Salvador',
      desired_skills: 'Orientado a prazos e qualidade',
      top_hourly_wage: 33,
      proposal_deadline: 3.weeks.from_now,
      remote: true
    )

    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).to have_css('h1', text: 'Website para grupo de estudos')
    expect(page).to have_content('Grupo de estudos liberal de Salvador')
    expect(page).to have_content('O que procuramos no freela: Orientado a prazos e qualidade')
    expect(page).to have_content('Máximo preço por hora: R$ 33,00')
    expect(page).to have_content("Data limite para envio de propostas: #{I18n.l 3.weeks.from_now.to_date}")
    expect(page).to have_content('Trabalho remoto: sim')
  end

  it 'and comes back to see another project details successfully' do
    create(
      :project,
      title: 'Website para grupo de estudos',
      description: 'Grupo de estudos liberal de Salvador',
      desired_skills: 'Orientado a prazos e qualidade',
      top_hourly_wage: 33,
      proposal_deadline: 3.weeks.from_now,
      remote: true
    )
    create(
      :project,
      title: 'Artes impressas para palestra',
      description: 'Campeonato de debates na USP',
      desired_skills: 'Pessoa criativa e dinâmica',
      top_hourly_wage: 45,
      proposal_deadline: 4.weeks.from_now,
      remote: false
    )

    visit root_path
    click_on 'Website para grupo de estudos'
    click_on 'Voltar'
    click_on 'Artes impressas para palestra'

    expect(page).to have_css('h1', text: 'Artes impressas para palestra')
    expect(page).to have_content 'Campeonato de debates na USP'
    expect(page).to have_content 'O que procuramos no freela: Pessoa criativa e dinâmica'
    expect(page).to have_content 'Máximo preço por hora: R$ 45,00'
    expect(page).to have_content "Data limite para envio de propostas: #{I18n.l 4.weeks.from_now.to_date}"
    expect(page).to have_content 'Trabalho remoto: não'
  end
end
