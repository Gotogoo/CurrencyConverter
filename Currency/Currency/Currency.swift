//
//  Currency.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

protocol Currency {
  var code: String { get }
  static func from(code: String) -> Currency?
}

enum CryptoCurrency: Currency, CaseIterable {
  case btc
  case eth

  var code: String {
    switch self {
    case .btc:
      return "BTC"
    case .eth:
      return "ETH"
    }
  }

  static func from(code: String) -> Currency? {
    switch code {
    case "BTC":
      return CryptoCurrency.btc
    case "ETH":
      return CryptoCurrency.eth
    default:
      return nil
    }
  }
}

enum LegalCurrency: Currency, CaseIterable {
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

  static func from(code: String) -> Currency? {
    switch code {
    case "RMB":
      return LegalCurrency.rmb
    case "USD":
      return LegalCurrency.usd
    default:
      return nil
    }
  }
}
