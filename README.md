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

### Interação

- **HomeViewController**: Configura e atualiza a interface do usuário com os dados fornecidos pelo `HomeViewModel`.
- **HomeViewModel**: Busca os dados do `DigioStoreService` e formata-os para exibição.
- **AppCoordinator e MainCoordinator**: Gerenciam a navegação e a coordenação entre as diferentes telas do aplicativo.
- **HomeView**: Configura a interface do usuário e gerencia o layout dos componentes.
- **ErrorViewController**: Exibe mensagens de erro quando o serviço está indisponível ou não há conexão com a internet.

### Tratamento de Erros

O aplicativo inclui uma tela de erro (`ErrorViewController`) para lidar com dois tipos de erro:

1. **Sem conexão com a internet**:
    - Exibe uma mensagem indicando a falta de conexão com a internet.
    - Inclui um botão "Tentar novamente" para reavaliar a conectividade e tentar carregar os dados novamente.
    - Inclui um botão "X" no canto superior esquerdo que fecha totalmente a aplicação.

2. **Erro desconhecido**:
    - Exibe uma mensagem genérica indicando que algo deu errado.
    - Inclui um botão "Tentar novamente" para tentar carregar os dados novamente.

## Observação sobre telas de erro:

As telas de erro têm um botão de "Tentar novamente", já que não consegui testar uma reconexão com a internet (o simulador não reconhecia essa reconexão). Adicionei um botão "X" que fecha totalmente a aplicação para o usuário não ficar preso naquela tela. Considero isso um bug na minha aplicação ja que nao tenho celular fisico para fazer um teste melhor e confirmar esse problema e nao estou achando a origem do problema no codigo. 

### NetworkMonitor

O `NetworkMonitor` utiliza o framework `Network` para monitorar a conectividade da rede. Ele notifica o `HomeViewController` sobre mudanças no status da rede para que a UI possa ser atualizada adequadamente.

### Estrutura do Projeto

- `DigioStore/`: Pasta raiz do projeto.
- `ViewModel/`: Contém o arquivo `HomeViewModel`.
- `DigioCell/`: Contém os arquivos `SpotlightCell` e `ProductCell`.
- `Managers/`: Contém o arquivo `DigioStoreService`.
- `Models/`: Contém o arquivo `DigioStoreModel`.
- `ViewControllers/`: Contém o arquivo `HomeViewController` e  `ErrorViewController`.
- `Coordinator/`: Contém os arquivos `AppCoordinator`, `MainCoordinator`, `Coordinator`.
- `Views/`: Contém o arquivo `HomeView`.
 
 
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
    - Selecione o dispositivo ou simulador desejado.
    - Clique no botão "Run" ou pressione `Cmd + R`.
    
Este projeto utiliza o [SwiftLint](https://github.com/realm/SwiftLint) para garantir que o código siga as melhores práticas e padrões de estilo do Swift.

#### Instalação do SwiftLint

Se você ainda não tem o SwiftLint instalado, pode instalá-lo usando [Homebrew](https://brew.sh/):

```bash
brew install swiftlint

## Uso

A tela inicial (`HomeViewController`) exibe uma saudação personalizada, uma coleção de destaques (`spotlightCollectionView`), um banner de cash (`cashBannerImageView`) e uma coleção de produtos (`productsCollectionView`).

### Interação

- **HomeViewController**: Configura e atualiza a interface do usuário com os dados fornecidos pelo `HomeViewModel`.
- **HomeViewModel**: Busca os dados do `DigioStoreService` e formata-os para exibição.
- **AppCoordinator** e **MainCoordinator**: Gerenciam a navegação e a coordenação entre as diferentes telas do aplicativo.
- **HomeView**: Configura a interface do usuário e gerencia o layout dos componentes.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

### Para Contribuir

1. Faça um fork do projeto.
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

