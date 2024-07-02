# Digio Store App

Este projeto é um exemplo de um aplicativo iOS que exibe uma loja Digio, refatorado para usar a arquitetura MVVM-C (Model-View-ViewModel-Coordinator).

## Visão Geral

O objetivo deste projeto é demonstrar como organizar e separar responsabilidades em um aplicativo iOS usando a arquitetura MVVM-C. Isso resulta em um código mais modular, testável e fácil de manter.

## Arquitetura

### MVVM-C

- **Model**: Representa os dados e a lógica de negócios da aplicação.
- **View**: Responsável por exibir a interface do usuário e interagir com o usuário.
- **ViewModel**: Contém a lógica de apresentação e se comunica com o Model para buscar e formatar os dados que serão exibidos pela View.
- **Coordinator**: Gerencia a navegação entre as telas.

- **Controller**: Resposavel por configurar a View, liga a View e a ViewModel, captura os eventos de interacao com usuario e direciona para a ViewModel onde acontece o processamento, gerencia ciclo de vida: viewDidLoad, viewWillAppear, viewWillDesapper...

### Model

`DigioStoreModel.swift`: Contém a estrutura de dados para armazenar informações da loja Digio.

### View

- `HomeView.swift`: Configura e gerencia os componentes da interface do usuário.
- `SpotlightCell.swift` e `ProductCell.swift`: Células customizadas usadas nas `UICollectionView`s.

### ViewModel

`HomeViewModel.swift`: Contém a lógica de apresentação e comunica-se com o serviço para buscar dados.

### Coordinator

- `AppCoordinator.swift`: Gerencia a inicialização e navegação principal do aplicativo.
- `MainCoordinator.swift`: Coordena a navegação específica para a tela principal.
- `Coordinator.swift`: Protocolo base para todos os coordinators.

### Services

`DigioStoreService.swift`: Serviço responsável por buscar os dados da loja Digio.

## Atualização para Swift 4.2

Este projeto foi atualizado para usar Swift 4.2. 

## Configuração

### Pré-requisitos

- Xcode 15.4+
- Swift 4.2+
- Deployment Target iOS 12
- Swiftlint (integrado com Xcode)

### Swiftlint 

- Instalar Swiftlint usando Homebrew:

 1. brew install swiftlint


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

## Uso

A tela inicial (`HomeViewController`) exibe uma saudação personalizada, uma coleção de destaques (`spotlightCollectionView`), um banner de cash (`cashBannerImageView`) e uma coleção de produtos (`productsCollectionView`).

### Interação

- **HomeViewController**: Configura e atualiza a interface do usuário com os dados fornecidos pelo `HomeViewModel`.
- **HomeViewModel**: Busca os dados do `DigioStoreService` e formata-os para exibição.
- **AppCoordinator** e **MainCoordinator**: Gerenciam a navegação e a coordenação entre as diferentes telas do aplicativo.
- **HomeView**: Configura a interface do usuário e gerencia o layout dos componentes.


### Tratamento de Erro das Imagens relacionado ao item 'Problemas encontrados' ao final do Readme. 

O tratamento de erro da imagem foi implementado para todas as imagens, pois a terceira imagem da lista de produtos estava ficando em branco como 
se nada tivesse ali. Agora, o usuário tem um feedback que ali deveria ter uma imagem.

### Motivo da Escolha da Arquitetura MVVM-C

Foi a arquitetura que mais tive contato nos dois projetos que trabalhei tanto no Itaú, quanto na Porto Seguro.
Tive contato com VIP, mas muito pouco, então decidi fazer usando algo que vi mais 
presente nos projetos que vivenciei.

### Testes Unitários

Foram realizados alguns testes unitários que julguei importantes sobre as ViewModels, mas acredito que é possível fazer mais testes para aumentar a cobertura.

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
2. **Testes Unitários**: Facilita a criação de mocks e stubs para testes.
3. **Facilidade de Manutenção**: Reduz o impacto das mudanças na implementação da ViewModel.
4. **Reutilização**: Permite que o protocolo seja reutilizado em diferentes contextos. Por exemplo, se você tiver diferentes tipos de ViewModels
 que compartilham uma interface comum, eles podem todos implementar o mesmo protocolo.
5. **Clareza do Código**: Define claramente quais são os requisitos de uma classe ou struct.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

### Para Contribuir

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
  
