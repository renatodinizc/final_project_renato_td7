require 'rails_helper'

describe 'Contractor receives proposal request email' do
  it 'successfully' do
    spongebob = create(:freelancer)
    create(:project, title: 'Plataforma de desafios de programação')
    mailer_spy = class_spy ProposalMailer
    stub_const 'ProposalMailer', mailer_spy
    mail = double('ProposalMailer')
    allow(ProposalMailer).to receive(:notify_new_proposal).and_return(mail)
    allow(mail).to receive(:deliver_now)

    login_as spongebob, scope: :freelancer
    visit root_path
    click_on 'Plataforma de desafios de programação'
    fill_in 'Justificativa', with: 'Fui aluno do TD7 e quero contribuir com o projeto'
    fill_in 'Valor/hora', with: 14
    fill_in 'Horas semanais', with: 20
    fill_in 'Conclusão esperada', with: 3.months.from_now
    click_on 'Enviar proposta'

    # expect(ActionMailer::Base.deliveries.count).to eq 1
    expect(mail).to have_received(:deliver_now)
    expect(ProposalMailer).to have_received(:notify_new_proposal)
  end
end
