require 'rails_helper'

describe 'Freelancer makes proposal to project' do
  it 'successfully' do
    spongebob = create(:freelancer)
    create(:project, title: 'Plataforma de desafios de programação')

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Plataforma de desafios de programação'
    fill_in 'Justificativa', with: 'Fui aluno do TD7 e quero contribuir com o projeto'
    fill_in 'Valor/hora', with: 14
    fill_in 'Horas semanais', with: 20
    fill_in 'Conclusão esperada', with: 3.months.from_now
    click_on 'Enviar proposta'

    expect(page).to have_content 'Plataforma de desafios de programação'
    expect(page).to have_content 'Suas propostas:'
    expect(page).to have_content 'Justificativa: Fui aluno do TD7 e quero contribuir com o projeto'
    expect(page).to have_content 'Valor/hora: R$ 14,00'
    expect(page).to have_content 'Carga horária semanal: 20 horas'
    expect(page).to have_content "Conclusão esperada: #{I18n.l 3.months.from_now.to_date}"
    expect(page).to have_content 'Status da proposta: Pendente'
  end

  it 'and access it through My projects menu' do
    proposal1 = create(:proposal)
    create(:proposal, freelancer: proposal1.freelancer)
    create(:proposal)

    login_as proposal1.freelancer, scope: :freelancer
    visit root_path
    click_on 'Meus projetos'

    expect(page).to have_content 'Meus projetos:'
    expect(page).to have_link 'Project 1'
    expect(page).to have_content 'Status da proposta: Pendente'
    expect(page).to have_link 'Project 2'
    expect(page).to have_content 'Status da proposta: Pendente'
    expect(page).not_to have_link 'Project 3'
  end
end
