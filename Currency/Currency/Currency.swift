//
//  Currency.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

protocol Currency {
  var code: String { get }
}

enum CryptoCurrency: Currency {
  case btc(_ parameter: String)
  case eth(_ parameter: String)

  var code: String {
    switch self {
    case .btc:
      return "BTC"
    case .eth:
      return "ETH"
    }
  }
}

enum LegalCurrency: Currency {
  case rmb
  case usd

  var code: String {
    switch self {
    case .rmb:
      return "RMB"
    case .usd:
      return "USD"
    }
  }
}
