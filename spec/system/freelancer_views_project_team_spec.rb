require 'rails_helper'

describe 'Freelancer views project team' do
  it 'successfully' do
    proposal1 = create(:proposal, status: 'proposal_approved')
    proposal2 = create(:proposal, project: proposal1.project, status: 'proposal_approved')
    proposal3 = create(:proposal, project: proposal1.project, status: 'proposal_denied')
    proposal4 = create(:proposal, project: proposal1.project)

    login_as proposal1.freelancer, scope: :freelancer
    visit root_path
    click_on 'Meus projetos'
    click_on 'Project 1'

    expect(page).to have_content "Nome social: Freelancer 1"
    expect(page).to have_content "Nome social: Freelancer 2"
    expect(page).not_to have_content 'Nome social: Freelancer 3'
    expect(page).not_to have_content 'Nome social: Freelancer 4'
  end
end