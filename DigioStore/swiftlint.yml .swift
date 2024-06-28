//
//  swiftlint.yml .swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import Foundation

disabled_rules: # desabilita algumas regras específicas
  - trailing_whitespace
  - line_length
  - identifier_name

opt_in_rules: # habilita algumas regras específicas
  - empty_count
  - first_where

included: # inclui apenas os seguintes diretórios e arquivos para serem verificados
  - DigioStore

excluded: # exclui os seguintes diretórios e arquivos
  - Pods
  - Carthage
  - fastlane
  - DigioStore/Generated

line_length: 120 # customiza a regra de comprimento máximo de linha para 120 caracteres
