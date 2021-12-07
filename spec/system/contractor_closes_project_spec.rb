require 'rails_helper'

describe 'Contractor closes' do
  context 'receipt of new proposals' do
    it 'successfully' do
      foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      Project.create!(title: 'Website para grupo de estudos',
                      description: 'Grupo de estudos liberal de Salvador',
                      desired_skills: 'Orientado a prazos e qualidade',
                      top_hourly_wage: 45,
                      proposal_deadline: '10/12/2021',
                      remote: true,
                      contractor: foo,
                      freelancer_expertise: webdev)

      login_as foo, scope: :contractor
      visit root_path
      click_on 'Website para grupo de estudos'
      click_on 'Encerrar inscrições'
      visit root_path

      expect(page).not_to have_content 'Website para grupo de estudos'
    end

    it 'and view its details successfully' do
      foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      Project.create!(title: 'Website para grupo de estudos',
                      description: 'Grupo de estudos liberal de Salvador',
                      desired_skills: 'Orientado a prazos e qualidade',
                      top_hourly_wage: 45,
                      proposal_deadline: '10/12/2021',
                      remote: true,
                      contractor: foo,
                      freelancer_expertise: webdev)

      login_as foo, scope: :contractor
      visit root_path
      click_on 'Website para grupo de estudos'
      click_on 'Encerrar inscrições'

      expect(page).to have_content 'RECEBIMENTO DE PROPOSTAS PARA PROJETO ENCERRADAS'
      expect(page).to have_content 'Website para grupo de estudos'
    end

    it 'and denies all pending proposals successfully' do
      peter = Contractor.create!(email: 'peterparker@hub.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123',
                                     full_name: 'Sponge Bob SquarePants',
                                     social_name: 'Sponge Bob', birth_date: '14/07/1986',
                                     degree: 'Cooking',
                                     description: 'Já trabalhei em águas internacionais',
                                     experience: 'Já trabalhei como chef no Siri Cascudo',
                                     freelancer_expertise: webdev)
      website = Project.create!(title: 'Website para grupo de estudos',
                                description: 'Grupo de estudos liberal de Salvador',
                                desired_skills: 'Orientado a prazos e qualidade',
                                top_hourly_wage: 40,
                                proposal_deadline: '10/12/2021', remote: true, contractor: peter,
                                freelancer_expertise: webdev)
      Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                       hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                       project: website, freelancer: spongebob, contractor: peter)

      login_as peter, scope: :contractor
      visit root_path
      click_on 'Website para grupo de estudos'
      click_on 'Encerrar inscrições'

      expect(page).to have_content 'Sponge Bob'
      expect(page).to have_content 'Descrição do profissional: Já trabalhei em águas internacionais'
      expect(page).to have_content 'Status da proposta: Recusada'
      expect(page).to have_content 'Motivo: Contratante fechou projeto para recebimento de novas propostas'
    end
  end

  context 'the project definitely' do
    it 'successfuly' do
      foo = Contractor.create!(email: 'foo@bar.com', password: '123123')
      webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
      Project.create!(title: 'Website para grupo de estudos',
                      description: 'Grupo de estudos liberal de Salvador',
                      desired_skills: 'Orientado a prazos e qualidade',
                      top_hourly_wage: 45,
                      proposal_deadline: '10/12/2021',
                      remote: true,
                      contractor: foo,
                      freelancer_expertise: webdev)

      login_as foo, scope: :contractor
      visit root_path
      click_on 'Website para grupo de estudos'
      click_on 'Fechar projeto'

      expect(page).to have_content 'PROJETO ENCERRADO'
    end
  end
end
