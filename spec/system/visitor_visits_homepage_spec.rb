require 'rails_helper'

describe 'Visitor visits homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
  end

  it 'and sees message if there are no projects sucessfully' do
    visit root_path

    expect(page).to have_content('Ainda não existem projetos cadastrados')
  end

  it 'and sees all avaiable projects successfully' do
    create(:project, title: 'Website para grupo de estudos')
    create(:project, title: 'Artes impressas para palestra')

    visit root_path

    expect(page).to have_content('Website para grupo de estudos')
    expect(page).to have_content('Artes impressas para palestra')
  end
end
