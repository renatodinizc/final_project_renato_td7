require 'rails_helper'

describe 'Contractor deletes project' do
  it 'successfully' do
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
    click_on 'Remover projeto'
    
    expect(page).to have_css('h1', text: 'Bem vindo ao FreelancingHUB')
    expect(page).not_to have_content('Website para grupo de estudos')
  end
end