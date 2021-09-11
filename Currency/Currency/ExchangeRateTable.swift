//
//  ExchangeRateTable.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

struct ExchangeRateTable {
  var table: [String: Double]

  init(_ table: [String: Double] = [:]) {
    self.table = table
  }

  func get(for pair: CurrencyPair) -> Double? {
    return table[pair.code]
  }

  mutating func set(exchangeRate: Double, for pair: CurrencyPair) {
    table[pair.code] = exchangeRate
  }
}
