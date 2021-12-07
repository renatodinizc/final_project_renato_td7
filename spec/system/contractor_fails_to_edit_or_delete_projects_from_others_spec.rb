require 'rails_helper'

describe 'Contractor fails to' do
  it 'edit projects from others' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    spongebob = Contractor.create!(email: 'spongebob@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: spongebob,
                    freelancer_expertise: webdev)

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).not_to have_link 'Editar informações do projeto'
  end
  it 'delete projects from others' do
    foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
    spongebob = Contractor.create!(email: 'spongebob@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: spongebob,
                    freelancer_expertise: webdev)

    login_as foo, scope: :contractor
    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).not_to have_link 'Remover projeto'
  end
end
