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

## Estrutura do Projeto
 
 adicionar imagem da estratura final. 
 
 
 
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

## Uso

A tela inicial (`HomeViewController`) exibe uma saudação personalizada, uma coleção de destaques (`spotlightCollectionView`), um banner de cash (`cashBannerImageView`) e uma coleção de produtos (`productsCollectionView`).

### Interação

- **HomeViewController**: Configura e atualiza a interface do usuário com os dados fornecidos pelo `HomeViewModel`.
- **HomeViewModel**: Busca os dados do `DigioStoreService` e formata-os para exibição.
- **AppCoordinator** e **MainCoordinator**: Gerenciam a navegação e a coordenação entre as diferentes telas do aplicativo.
- **HomeView**: Configura a interface do usuário e gerencia o layout dos componentes.

## Problemas Encontrados

### Problema de Acesso às Imagens

Durante o desenvolvimento, encontramos um problema onde uma das URLs das imagens dos produtos retornava um erro de "Access Denied". 

#### Erro de Exemplo que aparece no meu navegador, apesar disso a celula que retornaria essa imagem ao clicar leva para uma pagina de detalhes:

```xml
<Error>
  <Code>AccessDenied</Code>
  <Message>Access Denied</Message>
  <RequestId>BVV9TNB7RZYSZ0G9</RequestId>
  <HostId>u1H0wbohaDrAS+G8FPuFtekoAjHZVdocW7rE0xhLgeS46KntuiZevwxUn76M0stOHfPSCw/+XUo=</HostId>
</Error>

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

