# Contractors
renato = Contractor.create!(email: 'renato@hub.com', password: '123123')
joao = Contractor.create!(email: 'joao@hub.com', password: '123123')

# Freelancers Expertises
webdev = FreelancerExpertise.create!(title: 'Desenvolvedor web')
ux = FreelancerExpertise.create!(title: 'UX')
designer = FreelancerExpertise.create!(title: 'Designer')

# Freelancers
sandy = Freelancer.create!(email: 'sandycheecks@hub.com', password: '123123', full_name: 'Sandra Jennifer Cheeks',
                          social_name: 'Sandy', birth_date: '20/04/1990', degree: 'Engenharia',
                          description: 'Vim da superficie para viver aqui', experience: 'Sou bastante esforçada e dedicada',
                          freelancer_expertise: ux)
spongebob = Freelancer.create!(email: 'spongebob@hub.com', password: '123123', full_name: 'Sponge Bob SquarePants',
                          social_name: 'Sponge Bob', birth_date: '14/07/1986', degree: 'Cooking',
                          description: 'Ja trabalhei em aguas internacionais, lido bem sob pressao e guardo bem os segredos',
                          experience: 'Já trabalhei como chef no Siri Cascudo', freelancer_expertise: webdev)
squidward = Freelancer.create!(email: 'squidward@hub.com', password: '123123', full_name: 'Squidward Tentacles',
                            social_name: 'Squidward', birth_date: '20/04/1973', degree: 'Contabilidade',
                            description: 'Gosto de organizaçao e pontualidade nos meus trabalhos',
                            experience: 'Ja trabalhei como contador e caixa no Siri Cascudo', freelancer_expertise: webdev)

# Projects
website = Project.create!(title: 'Website para grupo de estudos', description: 'Grupo de estudos liberal de Salvador',
                          desired_skills: 'Orientado a prazos e qualidade', top_hourly_wage: 60,
                          proposal_deadline: '10/12/2021', remote: true, contractor: renato, freelancer_expertise: webdev)
artes =Project.create!(title: 'Artes impressas para palestra',
                        description: 'Campeonato de debates na USP', desired_skills: 'Pessoa criativa e dinamica',
                        top_hourly_wage: 50, proposal_deadline: '08/06/2021',
                        remote: false, contractor: renato, freelancer_expertise: ux)
desafios = Project.create!(title: 'Plataforma de desafios de programacao', description: 'Pessoal da Campus Code',
                          desired_skills: 'Esforcada, obstinada e cuidadosa', top_hourly_wage: 87,
                          proposal_deadline: '22/01/2022', remote: true, contractor: renato, freelancer_expertise: webdev)
      
# Proposals
Proposal.create!(proposal_description: 'Me divirto trabalhando e realizando projetos novos',
                            hourly_wage: 14, weekly_hours: 7, expected_conclusion: '22/01/2022',
                            project: website, freelancer: sandy, contractor: renato)
Proposal.create!(proposal_description: 'Quero ganhar experiencia com projetos na area',
                            hourly_wage: 25, weekly_hours: 10, expected_conclusion: '10/01/2022',
                            project: website, freelancer: spongebob, contractor: renato)