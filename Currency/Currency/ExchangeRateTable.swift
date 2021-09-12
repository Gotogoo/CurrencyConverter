//
//  ExchangeRateTable.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

typealias ExchangeRateModel = [String: Double]

struct ExchangeRateTable {
  private var table: ExchangeRateModel

  // `overwrite` flag indicate whether overwrite the existed key value
  // in property list.
  static func write(_ newTable: ExchangeRateModel, overwrite: Bool = true) {
    let currentTable = loadPropertyList() ?? [:]
    let mergedTable = overwrite ?
      currentTable.merging(newTable) { (_, new) in new } :
      currentTable.merging(newTable) { (current, _) in current }
    savePropertyList(model: mergedTable)
  }

  init() {
    table = [:]
    reload()
  }

  func get(for pair: CurrencyPair) -> Double? {
    return table[pair.code]
  }

  // set exchangeRate for one pair
  mutating func set(exchangeRate: Double, for pair: CurrencyPair) {
    set(with: [pair.code: exchangeRate])
  }

  // set exchangeRates for a series of pairs
  mutating func set(with newTable: ExchangeRateModel) {
    table = table.merging(newTable) { (_, new) in new }
    ExchangeRateTable.savePropertyList(model: table)
    reload()
  }

  mutating func reload() {
    table = ExchangeRateTable.loadPropertyList() ?? [:]
  }

  mutating func clear() {
    ExchangeRateTable.savePropertyList(model: [:])
    reload()
  }

  func ratesDescription() -> String {
    zip(table.keys, table.values)
      .map { key, value in "\(key): \(value)" }
      .sorted()
      .joined(separator: "\n")
  }
}

extension ExchangeRateTable: PorpertyListCodable {
  typealias Model = ExchangeRateModel

  static var fileName: String {
    return "ExchangeRateTable.plist"
  }
}
