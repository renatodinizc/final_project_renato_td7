require 'rails_helper'

describe 'Project API' do
  context 'GET /api/v1/projects' do
    it 'should receive projects successfully' do
      create(:project, title: 'Website para grupo de estudos')
      create(:project, title: 'Artes impressas para palestra')

      get '/api/v1/projects'

      # Outra opção: expect(response.status).to eq(200)
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_body.first[:title]).to eq 'Website para grupo de estudos'
      expect(parsed_body.second[:title]).to eq 'Artes impressas para palestra'
      expect(parsed_body.count).to eq 2
    end

    it 'returns no projects' do
      get '/api/v1/projects'

      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/properties/:id' do
    it 'should receive a specific project successfully' do
      project = create(:project, title: 'Website para grupo de estudos',
                                 description: 'Grupo de estudos liberal de Salvador',
                                 desired_skills: 'Orientado a prazos e qualidade',
                                 top_hourly_wage: 60,
                                 proposal_deadline: '10/12/2021', remote: true)

      get "/api/v1/projects/#{project.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_body[:title]).to eq 'Website para grupo de estudos'
      expect(parsed_body[:description]).to eq 'Grupo de estudos liberal de Salvador'
      expect(parsed_body[:desired_skills]).to eq 'Orientado a prazos e qualidade'
      expect(parsed_body[:top_hourly_wage]).to eq '60.0'
    end

    it 'should return 404 if project does not exist' do
      get '/api/v1/projects/999'

      expect(response).to have_http_status 404
    end

    it 'should return 500 if database is not avaiable' do
      project = create(:project, title: 'Website para grupo de estudos',
                                 description: 'Grupo de estudos liberal de Salvador',
                                 desired_skills: 'Orientado a prazos e qualidade',
                                 top_hourly_wage: 60,
                                 proposal_deadline: '10/12/2021', remote: true)
      allow(Project).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/projects/#{project.id}"

      expect(response).to have_http_status 500
    end
  end

  context 'POST /api/v1/properties' do
    it 'should post a new project successfully' do
      # Arrange
      john = create(:contractor)
      webdev = create(:freelancer_expertise)

      # Act
      post '/api/v1/projects', params: { project: { title: 'Novo projeto',
                                                    description: 'Muito legal',
                                                    desired_skills: 'Proatividade',
                                                    top_hourly_wage: 34,
                                                    proposal_deadline: 1.month.from_now,
                                                    remote: true,
                                                    contractor_id: john.id,
                                                    freelancer_expertise_id: webdev.id } }

      # Assert
      expect(response).to have_http_status 201
      expect(response.content_type).to include 'application/json'
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_body[:id]).to eq Project.last.id
      expect(parsed_body[:title]).to eq 'Novo projeto'
      expect(parsed_body[:description]).to eq 'Muito legal'
      expect(parsed_body[:top_hourly_wage]).to eq '34.0'
    end
  end
end
