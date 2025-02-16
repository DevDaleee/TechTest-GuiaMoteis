# Guia Motel App - Teste Técnico

[![Assista a explicação da solução](https://img.shields.io/badge/Assista-Explicação%20da%20Solução-red)](https://youtu.be/2ejb6eTpIXE)

## Visão Geral

O Guia Motel é uma aplicação Flutter que ajuda usuários a encontrar e reservar quartos de motel. O app possui uma interface moderna e amigável com disponibilidade em tempo real, ofertas promocionais e informações detalhadas sobre quartos e comodidades.

## Funcionalidades

### 1. Navegação em Tempo Real
- Listagem dinâmica de motéis e quartos disponíveis
- Opções de filtro para comodidades específicas (hidro, piscina, etc.)
- Exibição de disponibilidade e preços atualizados
- Fotos em alta qualidade e descrições detalhadas dos quartos

### 2. Sistema de Filtros Inteligente
- Opções de reserva "Ir Agora" vs "Ir Outro Dia"
- Múltiplas categorias de filtro:
  - Quartos com desconto
  - Quartos disponíveis no momento
  - Quartos com comodidades específicas (hidro, piscina)
  - Filtro por localização

### 3. Recursos Promocionais
- Carrossel de ofertas promocionais
- Destaque para descontos
- Cálculos de preços especiais
- Integração com programa de fidelidade "GO Fidelidade"

### 4. Informações Detalhadas dos Quartos
- Fotos em alta resolução
- Ícones e descrições das comodidades
- Múltiplos períodos de preços
- Status de disponibilidade
- Sistema de avaliação integrado

### 5. Componentes de Interface
- AppBar personalizada com seletor de tipo de reserva
- Menu lateral deslizante
- Filtro de localização
- Botão de favoritos interativo
- Exibição de avaliações
- Cards promocionais com elementos animados

## Arquitetura Técnica

### Models
1. **MotelModel**
   - Estrutura principal para informações do motel
   - Propriedades: nome, logo, bairro, avaliações, etc.
   - Gerencia lista de suítes e metadados relacionados

2. **SuiteModel**
   - Representa suítes individuais
   - Gerencia fotos, comodidades e disponibilidade
   - Controla períodos de preços

3. **PeriodModel**
   - Gerencia preços baseados em período
   - Controla descontos e ofertas especiais
   - Formatação de exibição de tempo

4. **CategoryItemModel**
   - Gerencia categorias de comodidades
   - Controla URLs de ícones e nomes de exibição

### Componentes

1. **CustomAppBar**
   - Implementa seletor de tipo de reserva
   - Gerencia funcionalidade de busca
   - Controla estado da UI através do Provider

2. **CustomDrawer**
   - Implementa seção do programa de fidelidade
   - Itens do menu de navegação
   - Acesso à conta do usuário

3. **HotelCard**
   - Exibe informações do motel
   - Gerencia listagem de suítes
   - Controla funcionalidade de favoritos
   - Exibe avaliações e comentários

4. **PromoCard**
   - Exibe ofertas promocionais
   - Gerencia cálculos de desconto
   - Integração de elementos animados

5. **LocationFilter**
   - Gerencia filtragem por localização
   - Interface de seleção de região

### Serviços

1. **MotelServices**
   - Gerencia comunicação com API
   - Controla busca e análise de dados
   - Tratamento de erros para requisições de rede

2. **UtilsServices**
   - Fornece funções utilitárias
   - Gerencia formatação de moeda
   - Controla funções auxiliares comuns

### Gerenciamento de Estado

- Utiliza padrão Provider para gerenciamento de estado
- Implementa ChangeNotifier para atualizações reativas
- Gerencia estado do tipo de reserva
- Controla status de favoritos

## Fluxo de Dados

1. Busca inicial de dados através do MotelServices
2. Análise de dados em objetos modelo
3. Atualizações de estado através do Provider
4. Atualizações de UI baseadas em mudanças de estado
5. Tratamento de interação do usuário
6. Aplicação de filtros e atualizações de lista

## Dependências

- `provider`: Gerenciamento de estado
- `http`: Comunicação com API
- `intl`: Internacionalização e formatação
- `carousel_slider`: Carrossel promocional
- `animated_emoji`: Melhorias de UI
- `flutter_svg`: Manipulação de assets SVG

## Configuração e Instalação

1. Clone o repositório
```bash
git clone [url-do-repositório]
```

2. Instale as dependências
```bash
flutter pub get
```

3. Execute a aplicação
```bash
flutter run
```

## Estrutura do Projeto

```
lib/
├── data/
│   └── provider/
│       └── home_page_provider.dart
├── models/
│   ├── category_item_models.dart
│   ├── item_model.dart
│   ├── motel_model.dart
│   ├── period_model.dart
│   └── suite_model.dart
├── services/
│   ├── moteis.dart
│   └── utils.dart
└── src/
    └── home/
        └── components/
            ├── custom_app_bar.dart
            ├── custom_drawer.dart
            ├── hotel_card.dart
            ├── location_filter.dart
            ├── promo_card.dart
            └── suites_card.dart
```

## Integração com API

O app integra com um endpoint REST API:
```
https://www.jsonkeeper.com/b/1IXK
```

A estrutura da resposta inclui:
- Informações do motel
- Detalhes das suítes
- Dados de preços
- Status de disponibilidade
- Informações promocionais

## Diretrizes de Contribuição

1. Faça um fork do repositório
2. Crie uma branch para sua feature
3. Faça commit das alterações
4. Push para a branch
5. Crie um Pull Request

## Vídeo Explicativo

Para uma explicação detalhada da solução, assista ao vídeo abaixo:

[![Explicação da Solução](https://img.shields.io/badge/Assista-Explicação%20da%20Solução-red)](https://youtu.be/2ejb6eTpIXE)

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo LICENSE para detalhes.

## Créditos

Desenvolvido como solução para teste técnico, demonstrando capacidades de desenvolvimento Flutter e implementação de arquitetura moderna de aplicativos móveis.
