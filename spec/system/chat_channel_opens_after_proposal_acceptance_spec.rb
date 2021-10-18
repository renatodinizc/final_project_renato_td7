require 'rails_helper'

describe 'Chat channel opens after proposal acceptance' do
  it 'successfully' do
    peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
    webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
    ux = FreelancerExpertise.create!(title: 'UX')
    spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                              social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                              description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                              experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
    website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                              desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 10,
                              proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
    proposal = Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                                hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                                project: website, freelancer: spongebob) 

    login_as peter, scope: :contractor
    visit root_path
    click_on 'Ver meu perfil'
    click_on 'Website para grupo de estudos'
    #click_on 'Aprovar proposta'
    new_window = page.window_opened_by do
      click_on 'Aprovar proposta'
    end

    page.within_window(new_window) do
      expect(page).to have_css 'h1', text: 'Chat entre peterparker@hub.com e SpongeBob'
    end
    

  end
end