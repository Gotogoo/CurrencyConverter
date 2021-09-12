//
//  CurrencyConverter.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

struct CurrencyConverter {
  private let table: ExchangeRateTable

  init(_ table: ExchangeRateTable) {
    self.table = table
  }

  func convert(
    _ amount: Double,
    from: Currency,
    to: Currency
  ) -> Double? {
    let pair = CurrencyPair(source: from, target: to)
    guard let exchangeRate = table.get(for: pair) else {
      return nil
    }
    return amount * exchangeRate
  }
}
