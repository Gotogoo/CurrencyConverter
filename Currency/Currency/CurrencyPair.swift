//
//  CurrencyPair.swift
//  Currency
//
//  Created by Facheng Liang on 2021/9/11.
//

import Foundation

struct CurrencyPair {
  let source: Currency
  let target: Currency

  var code: String {
    [source, target]
      .map { $0.code }
      .joined(separator: "/")
  }
}
