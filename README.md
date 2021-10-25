# FreelancingHUB

FreelancingHUB é uma plataforam digital B2B gratuita, que visa à promoção de um ambiente de conexões de negócios com propósito social entre organizações de diferentes atividades e freelancers de todo o país.
Oferecemos aos freelancers a oportunidade de explorar diferentes projetos com privacidade, por meio de propostas de trabalho de acesso exclusivo aos contratantes do projeto aplicado. Aos contratantes, oferecemos a oportunidade de selecionar criteriosamente a equipe para seu projeto. Para isso, cada aplicação submetida ao seus projeto permite a o acesso ao perfil completo de informações sobre cada freelancer, em conjunto com todos os seus projetos executados no passado.

## Arquitetura e models principais

A Aplicação é regida por quatro models principais: Contractor, Freelancer, Project e Proposal:

* Os models 'Contractor' e 'Freelancer' são os usuários de acesso a plataforma. A maior parte das funcões somente é habilidade se ao menos uma dessas duas contas estiver autenticada.
* O model 'Project' armazena as informações de um novo projeto na plataforma título do projeto, descrição, custo/hora e outras informações. Ele pode ser gerado exclusivamente por um usuário do tipo 'Contractor' e armazena esta informação, proibindo edições futuras por outros Contractors que não sejam o criador original.
* O model 'Proposal' contém as interações entre os Freelancers e Contractors via Projects. Ele armazena parte substancial da lógica que possibilita a criação de outros models envolvidos na pltaforma como o 'Chat' e o 'Feedback'.

Arquitetura

* A aplicação segue arquitetura MVC, onde respeita-se o single responsibility principle.

## Models secundários

O projeto conta com outros models secundários que adicionam opções importantes para a plataforma como o 'FreelancerExpertise', que permite marcar um 'Project' ou 'Freelancer' com área de atuação específica. Os models 'Chat' e 'Feedback' armazenam respectivamente as funcionalidades de troca de mensagens entre usuários da plataforma e a informação de recusa de uma Proposal.

## Funcionalidades implementadas até o momento

* Contractor pode criar sua conta no sistema informando: um e-mail e uma senha.
* Contractor autenticado na plataforma pode cadastrar um novo projeto que precisa de profissionais.
* Um Project deve conter: título, descrição detalhada, descrição das habilidades desejadas, o valor máximo por hora que existe disponível para contratação, data limite para receber propostas e se o projeto demanda atuação presencial ou remota.
* Freelancer pode criar sua conta no sistema informando: um e-mail e uma senha.
* Freelancer só possui acesso as demais funcionalidades da plataforma se preencher seu perfil completo com nome completo, nome social, data de nascimento, formação, descrição e experiência profissional.
* Freelancer é capaz de visualizar e buscar projetos cadastrados na plataforma.
* Freelancer é capaz de submeter nova proposta para um projeto de preferência.
* Uma Proposal deve contar motivação, valor/hora, horas semanais disponíveis e expectativa de conclusão para o projeto.
* Proposal permanece com status 'Pendente' no momento de sua criação.
* Freelancer pode cancelar proposta caso ainda esteja com status 'Pendente'. Neste caso, Proposal é arquivada, perdendo sua visualização mas ainda mantendo-se seu registro no banco de dados da plataforma.
* Contractor é capaz de visualizar todas as Proposals realizadas para projetos de sua criação, acessar o perfil individual de cada Freelancer e poder aceitar ou recusar Proposals.
* Para realizar recusa de proposta, Contractor necessita criar e preencher um formulário informando a motivação de sua recusa.
* Caso Contractor aceite a Proposal, permite-se acesso ao Chat entre as duas partes.
* Chat permite acesso exclusivo ao Contractor criador do projeto e ao Freelancer criador da Proposal.
* Chat permite troca de mensagens, salvando o remetente e armazenando junto da mensagem correspondente para a exibição.

## Instalação e inicialização do projeto

INSTALAÇÃO

* Baixe o repositório
'''
git clone git@github.com:renatodinizc/final_project_renato_td7
cd final_project_renato_td7
'''

* Cheque sua versão de ruby
'ruby -v'

O resultado deve ser começar com 'ruby 3.0.2'

Em caso de diferença de versões, instale a versão referente ao projeto utilizando rbenv:

'rbenv install 3.0.2'

Instale as dependências utilizando Bundler e Yarn:

'bundle && yarn'

Para inicializar o servidor:
'rails s'

INICIALIZAÇÃO

O projeto conta com um arquivo de seeds recheado com os models principais para execução imediata da plataforma.
* Duas contas de Contractors
  • email: renato@hub.com password: 123123
  • email: joao@hub.com password: 123123
* Três tipos de FreelancerExpertise
  • Desenvolvedor web
  • UX
  • Designer
* Três contas de Freelancers
  • email: sandycheecks@hub.com password: 123123
  • email: spongebob@hub.com password: 123123
  • email: squidward@hub.com password: 123123
* Três Projects cadastrados
  • Website para grupo de estudos
  • Artes impressas para palestra
  • Plataforma de desafios de programação
* Duas Proposals realizadas
  • Proposal de sandycheecks@hub.com para 'Website para grupo de estudos'
  • Proposal de spongebob@hub.com para 'Website para grupo de estudos'

# Gems, dependências e versões

* Ruby version 3.0.2p107 (2021-07-07 revision 0db68f0233) [arm64-darwin20]

* Rails version 6.1.4.1

* System dependencies Mac OS Big Sur 11.6 ARMx86-64bits

* Database creation Sqlite3

* Database initialization Sqlite3

* SimpleCov - code coverage for Ruby

## Peculiaridades

Ao realizar signup com Freelancer, é necessário atualizar a página (F5) para seguir com formulário de cadastro.