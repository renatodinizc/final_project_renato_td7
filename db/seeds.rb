# Contractors
Contractor.create!(email: 'peterparker@hub.com', password: '123123')

# Freelancers Expertises
FreelancerExpertise.create!(title: 'Desenvolvedor web')
FreelancerExpertise.create!(title: 'UX')

# Freelancers
Freelancer.create!(email: 'janedoe@hub.com', password: '123123', full_name: 'Jane Doe',
                          social_name: 'Jane', birth_date: '20/04/1990', degree: 'Engenharia',
                          description: 'Preciso de um freela', experience: 'Já trabalhei em muitos projetos',
                          freelancer_expertise: ux)
Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                          social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                          description: 'Já trabalhei em águas internacionais, lido bem sob pressão e guardo bem os segredos',
                          experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
Freelancer.create!(email: 'squidward@hub.com', password: '123123', full_name: 'Squidward Tentacles',
                            social_name: 'Squidward', birth_date: '20/04/1973', degree: 'Contabilidade',
                            description: 'Gosto de organização e pontualidade nos meus trabalhos',
                            experience: 'Já trabalhei como contador e caixa no Siri Cascudo', freelancer_expertise: webdev)

# Projects
Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                          desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 60,
                          proposal_deadline: '10/12/2021', remote: true, contractor: peter, freelancer_expertise: webdev)
Project.create!(title: 'Artes impressas para palestra',
                        description: 'Campeonato de debates na USP', desired_skills: 'Pessoa criativa e dinâmica',
                        top_hourly_wage: 50, proposal_deadline: '08/06/2021',
                        remote: false, contractor: peter, freelancer_expertise: ux)
Project.create!(title: 'Plataforma de desafios de programação', description: 'Pessoal da Campus Code',
                          desired_skills: 'Esforçada, obstinada e cuidadosa', top_hourly_wage: 87,
                          proposal_deadline: '22/01/2022', remote: true, contractor: peter, freelancer_expertise: webdev)
      
# Proposals
Proposal.create!(proposal_description: 'Quero muito contribuir',
                            hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                            project: website, freelancer: jane, contractor: peter)
Proposal.create!(proposal_description: 'Quero ajudar a construir a liberdade',
                            hourly_wage: 8, weekly_hours: 10, expected_conclusion: '10/01/2022',
                            project: website, freelancer: spongebob, contractor: peter) 