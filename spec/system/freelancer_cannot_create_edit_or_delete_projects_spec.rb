require 'rails_helper'

describe "Freelancer cannot" do
  it 'create project successfuly' do
    foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')
    
    login_as foo, scope: :freelancer
    visit root_path
    
    expect(page).not_to have_link 'Cadastrar novo projeto'
  end
  
  it 'edit project successfuly' do
    foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    foobar = Contractor.create!(email: 'foobar@bar.com', password: '123123')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foobar,
                    freelancer_expertise: webdev)

    login_as foo, scope: :freelancer
    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).not_to have_link 'Editar informações do projeto'
  end

  it 'delete project successfuly' do
    foo = Freelancer.create!(email: 'foo@bar.com', password: '123123')
    foobar = Contractor.create!(email: 'foobar@bar.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    Project.create!(title: 'Website para grupo de estudos',
                    description: 'Grupo de estudos liberal de Salvador',
                    desired_skills: 'Orientado a prazos e qualidade',
                    top_hourly_wage: 10,
                    proposal_deadline: '10/12/2021',
                    remote: true,
                    contractor: foobar,
                    freelancer_expertise: webdev)

    login_as foo, scope: :freelancer
    visit root_path
    click_on 'Website para grupo de estudos'

    expect(page).not_to have_link 'Remover projeto'
  end
end
