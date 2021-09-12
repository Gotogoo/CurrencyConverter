//
//  CurrencyTests.swift
//  CurrencyTests
//
//  Created by Facheng Liang on 2021/9/12.
//

import Nimble
import Quick
@testable import Currency

class CurrencyConverterSpec: QuickSpec {

  override func spec() {
    describe("convert") {
      var exchangeRateTable: ExchangeRateTable!
      var currencyConverter: CurrencyConverter!

      context("given a currency pair which has exchange rate") {
        beforeEach {
          ExchangeRateTable.write(["BTC/USD": 100.1])
          exchangeRateTable = ExchangeRateTable()
          currencyConverter = CurrencyConverter(exchangeRateTable)
        }

        it("should return the correct result") {
          let result = currencyConverter.convert(
            100,
            from: CryptoCurrency.btc(""),
            to: LegalCurrency.usd
          )
          expect(result) == 10010.0
        }
      }

      context("given a currency pair which don't have exchange rate") {
        beforeEach {
          ExchangeRateTable.write(["BTC/USD": 100.1])
          exchangeRateTable = ExchangeRateTable()
          currencyConverter = CurrencyConverter(exchangeRateTable)
        }

        it("should return nil") {
          let result = currencyConverter.convert(
            100,
            from: LegalCurrency.rmb,
            to: LegalCurrency.usd
          )
          expect(result).to(beNil())
        }
      }
    }
  }
}
