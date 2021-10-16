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
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    designer = FreelancerExpertise.create!(title: 'Designer')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foo,
                    freelancer_expertise: webdev)
    Project.create!(title: 'Artes impressas para palestra',
                    description: 'Campeonato de debates na USP',
                    desired_skills: 'Pessoa criativa e dinâmica',
                    top_hourly_wage: 7,
                    proposal_deadline: '08/06/2021',
                    remote: false,
                    contractor: foo,
                    freelancer_expertise: designer)
    
    visit root_path

    expect(page).to have_content('Website para grupo de estudos')
    expect(page).to have_content('Artes impressas para palestra')
  end
end