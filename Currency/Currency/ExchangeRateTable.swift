//
//  ExchangeRateTable.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

typealias ExchangeRateModel = [String: Double]

struct ExchangeRateTable {
  private var _table: ExchangeRateModel!

  var table: ExchangeRateModel {
    get {
      return _table
    }
    set {
      _table = newValue
    }
  }

  init(_ newTable: ExchangeRateModel = [:]) {
    let currentTable = loadPropertyList() ?? [:]
    self.table = currentTable.merging(newTable) { (current, new) in current }
  }

  func get(for pair: CurrencyPair) -> Double? {
    return table[pair.code]
  }

  mutating func set(exchangeRate: Double, for pair: CurrencyPair) {
    table[pair.code] = exchangeRate
    savePropertyList(model: table)
  }
}

extension ExchangeRateTable: PorpertyListCodable {
  typealias Model = ExchangeRateModel

  var fileName: String {
    return "ExchangeRateTable.plist"
  }
}
