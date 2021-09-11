//
//  CurrencyConverter.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

struct CurrencyConverter {
  let table: ExchangeRateTable

  init(_ table: ExchangeRateTable) {
    self.table = table
  }

  func convert(
    _ amount: Double,
    from: Currency,
    to: Currency
  ) -> Double {
    let pair = CurrencyPair(source: from, target: to)
    guard let exchangeRate = table.get(for: pair) else {
      fatalError("Don't support convert from \(from.code) to \(to.code)")
    }
    return amount * exchangeRate
  }
}
