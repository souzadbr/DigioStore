# Digio Store App

Este projeto é um exemplo de um aplicativo iOS que exibe uma loja Digio, feito para usar a arquitetura MVVM-C (Model-View-ViewModel-Coordinator).

## Visão Geral

O objetivo deste projeto é demonstrar como organizar e separar responsabilidades em um aplicativo iOS usando a arquitetura MVVM-C. 
Isso resulta em um código mais modular, testável e fácil de manter.

## Arquitetura

### MVVM-C

- **Model**: Representa os dados e a lógica de negócios da aplicação.
- **View**: Responsável por exibir a interface do usuário e interagir com o usuário.
- **ViewModel**: Contém a lógica de apresentação e se comunica com o Model para buscar e formatar os dados que serão exibidos pela View.
- **Coordinator**: Gerencia a navegação entre as telas.

- **Controller**: Resposavel por configurar a View, liga a View e a ViewModel, captura os eventos de interacao com usuario e direciona para a ViewModel onde acontece o processamento, gerencia ciclo de vida: viewDidLoad, viewWillAppear, viewWillDesapper...

### Motivo da Escolha da Arquitetura MVVM-C

Foi a arquitetura que mais tive contato nos dois projetos que trabalhei tanto no Itaú, quanto na Porto Seguro.
Tive contato com VIP, mas muito pouco, então decidi fazer usando algo que vi mais presente nos projetos que vivenciei.

### Model

`DigioStoreModel.swift`: Contém a estrutura de dados para armazenar informações da loja Digio.

### View

- `HomeView.swift`: Configura os componentes da interface do usuário que aparece logo que o projeto builda.
- `ProductDetailView.swift`: Configura views que aparecem ao clicar nas imagens da sessao de produtos da Home trazendo detalhes do produto. 
- `BottonSheetView.swift`: Configura os componentes de uma Bootonsheet que sobe quando o Switch da Tela de ProductDetail fica ligado e o alert que aparece quando esse switch e desligaod pelo usuario. 
- `SpotlightCell.swift` e `ProductCell.swift`: Células customizadas usadas nas `UICollectionView`s dentro da HomeView para criar carrosel horizontal de imagens na primeira(SpotlightCell) e ultima sessao da Home (ProductCell).

### ViewModel

`HomeViewModel.swift`: Contém a lógica de apresentação e comunica-se com o serviço para buscar dados.

### Coordinator

- `AppCoordinator.swift`: Gerencia a inicialização e navegação principal do aplicativo.
- `MainCoordinator.swift`: Coordena a navegação específica para a tela principal. Inicialmente o protocolo Coordinator estava num arquivo separado, mas resolvi colocar ele dentro da MainCoordinator posteriomente, sendo ele a base para todos os coordinators que podem ser feitos na Main. Acabei colocar ele aqui dentro para me lembrar dele e o que ele carregava sem ter que abrir outro arquivo. 

Observacao: Um app com poucas telas pode ter sua navegacao usando Delegate, nesse caso quis usar o Coordinator, pois a longo prazo e crescimento
do app ele seria mais facil de manter concentrando as logicas de navegacao. 

### Services

`DigioStoreService.swift`: Serviço responsável por buscar os dados da loja Digio.

Foi utilizado URLSession que vem da biblioteca Foundation, uma API da Apple usada para baixar dados de ums ervidor, por exemplo. 
Essa classe implementa um protocolo e contem a logica de buscar dados usando o servico. 
O metodo fetch faz uma solicitacao e espera um resultado. Esse resultado pode ser sucesso(trazendo o objeto esperado) ou um erro. 
Nesse metodo ele cria uma URL a partir de uma String. Se for valida ele segue, se nao for valida ele devolve um erro. 

Se ele recebe um dado, ele tenta fazer a decodificacao desse dado que tambem pode trazer sucesso (dado) ou falha (erro). 
Quem esta fazendo o papel de decodoficar o que recebe aqui na Service se chama JSONDecoder. 

### Tratamento de Erro das Imagens relacionado ao item 'Problemas encontrados' ao final do Readme. 

O tratamento de erro da imagem foi implementado para todas as imagens, pois a terceira imagem da lista de produtos estava ficando em branco como 
se nada tivesse ali. Agora, o usuário tem um feedback que ali deveria ter uma imagem.

### Testes Unitários

Foram realizados alguns testes unitários que julguei importantes sobre as ViewModels e Coordinator. 
Cobertura de teste 76%

### Estrutura da Home

A estrutura da Home foi feita usando StackView e nisso foi empilhada uma CollectionView para poder ter um scroll horizontal, algumas views e 
abaixo outra CollectionView para também ter um scroll horizontal para visualizar todas as imagens de produtos da lista. Foi escolhida CollectionView pelo fato 
de ter o scroll horizontal e também caso venha a ter mais produtos é de fácil inclusão para os casos de mais de um item de forma horizontal na tela.

### Ponto de Atenção

A Home poderia ter sido construída usando TableView, caso tivesse adição de itens futuramente, ser uma manutenção menos custosa. 
Pensei nisso posteriormente. Fica a observação que seria realmente uma melhor escolha do que construir com StackView, mas sendo uma 
jornada que não teria mudança a longo prazo, não vejo problema. Porém, sendo uma Home de fato onde o cliente tem acesso a maior parte 
das jornadas, a TableView seria a melhor escolha e melhor manutenção a curto prazo.

### Uso de Protocolos nas ViewModels

Optei pelo uso dos protocolos por ser uma prática que aprendi em um dos projetos que trabalhei. Essa prática traz algumas vantagens ajudando 
na questão de testes e manutenção:

1. **Desacoplamento**: A View vai ter uma referência do protocolo e não diretamente da ViewModel e com isso ela não conhece a implementação,
 mas sabe que o protocolo é cumprido pela ViewModel.
2. **Testes Unitários**: Facilita a criação de mocks para testes.
3. **Facilidade de Manutenção**: Reduz o impacto das mudanças na implementação da ViewModel.
4. **Reutilização**: Permite que o protocolo seja reutilizado em diferentes contextos. Por exemplo, se você tiver diferentes tipos de ViewModels
 que compartilham uma interface comum, eles podem todos implementar o mesmo protocolo.
5. **Clareza do Código**: Define claramente quais são os requisitos de uma classe ou struct.

## Configuração

### Pré-requisitos

- Xcode 15.4+
- Swift 4.2+
- Deployment Target iOS 12
- Swiftlint (integrado com Xcode, passo a passo no fim do readme)

### Melhorias que podem ser feitas posteriomente:
- Swiftgen (Localizeble.string)
    
### Instalação

1. Clone o repositório:
    ```bash
    git clone https://github.com/seu-usuario/digio-store.git
    ```

2. Abra o projeto no Xcode:
    ```bash
    cd digio-store
    open DigioStore.xcodeproj
    ```

3. Execute o projeto:
    - Selecione o dispositivo ou simulador desejado: durante o desenvolvumentofoi feito teste no dispositivo iphone 15 pro. 
    - Clique no botão "Run" ou pressione `Cmd + R`.

## Contribuição com DigioStore

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

### Para Contribuir no projeto DigioStore

1. Faça um fork do projeto.
    ```bash
    git clone https://github.com/seu-usuario/digio-store.git
    ```
2. Crie uma branch para sua feature/fix:
    ```bash
    git checkout -b minha-feature
    ```
3. Faça commit das suas alterações:
    ```bash
    git commit -m 'Adiciona nova feature'
    ```
4. Faça push para a branch:
    ```bash
    git push origin minha-feature
    ```
5. Abra um Pull Request.

## Problemas Encontrados

### Problema de Acesso às Imagens

Durante o desenvolvimento, encontrei um problema onde uma das URLs das imagens dos produtos retornava um erro de "Access Denied". 

#### Erro de Exemplo que aparece no meu navegador, apesar disso a celula que retornaria essa imagem ao clicar leva para uma pagina de detalhes:
  <Code>AccessDenied</Code>
  

## Swiftlint 

- Instalar Swiftlint usando Homebrew:

 1. brew install swiftlint

Tive alguns problemas para configurar o Swiftlint e fiquei um bom tempo tentando resolver. Ele rodoava e trazia as 
violacoes no terminal, mas o Xcode nao conseguia se vincular para rodar junto com o build. 

Passos que ocorreram para resolver o problema:

1. Descobrir o prefixo do Homebrew:
Primeiro verifique onde o Homebrew esta instalado:

brew --prefix 

Isso retorna  o caminho do prefixo onde o Homebrew esta instalado.

2. Adicionar o caminho ao PATH

Adicione o caminho correto ao seu PATH. Supondo que o prefixo do Homebrew que retorna e /opt/homebrew, voce pode adicionar esse caminho 
ao PATH no seu shell de configuracao. 
Dependendo do shell que voce esta usando (Bash, Zsh, etc) voce precisa editar o arquivo de configuracao correspondente:

- Para Bash (~/.bash_profile ou ~/.bashrc):
    
    echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.bash_profile
    
- Verificando o PATH:
    Depois de atualizar o PATH, verifique se o SwiftLint está acessível:
    
    which swiftlint
    Isso deve retornar /opt/homebrew/bin/swiftlint.

Agora dentro do Xcode vamos atualizar o Script de Fase de Construção no Xcode
    Para garantir que o SwiftLint é executado corretamente ao buildar seu projeto no Xcode, atualize o script de fase de construção para usar o caminho completo:
        1. No navegador de projetos, selecione seu projeto.
        2. Selecione o seu alvo (target) na lista de alvos.
        3. Vá para a aba Build Phases.
        4. Clique no botão "+" no canto superior esquerdo e selecione New Run Script Phase.
        5. Arraste a nova fase de execução para que fique abaixo de Compile Sources e acima de Link Binary With Libraries.
        6. No campo de script da nova fase de execução, adicione o seguinte:
    
    
    if [ -x /opt/homebrew/bin/swiftlint ]; then
        /opt/homebrew/bin/swiftlint
      else
        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
   Fi
    
    Reiniciar o Xcode
    Após atualizar o script de fase de construção, reinicie o Xcode para garantir que as alterações sejam aplicadas.
    Verificar o Funcionamento
        1. Faça uma limpeza do projeto no Xcode (Cmd + Shift + K).
        2. Recompile o projeto (Cmd + B).  
