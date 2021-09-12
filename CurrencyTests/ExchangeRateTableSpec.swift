//
//  ExchangeRateTableSpec.swift
//  ExchangeRateTableSpec
//
//  Created by Facheng Liang on 2021/9/12.
//

import Nimble
import Quick
@testable import Currency

class ExchangeRateTableSpec: QuickSpec {

  override func spec() {
    describe("write") {
      var exchangeRateTable: ExchangeRateTable!
      let currencyPair1 = CurrencyPair(
        source: CryptoCurrency.btc,
        target: LegalCurrency.usd
      )
      let currencyPair2 = CurrencyPair(
        source: CryptoCurrency.eth,
        target: LegalCurrency.usd
      )
      context("given the new table has an existed exchange rate") {
        beforeEach {
          ExchangeRateTable.write([currencyPair1.code: 100.1], overwrite: true)
          exchangeRateTable = ExchangeRateTable()
        }
        context("given overwrite is true") {
          beforeEach {
            ExchangeRateTable.write([currencyPair1.code: 200.2], overwrite: true)
            exchangeRateTable = ExchangeRateTable()
          }
          it("should keep the new exchange rate") {
            let rate = exchangeRateTable.get(for: currencyPair1)
            expect(rate) == 200.2
          }
        }

        context("given overwrite is false") {
          beforeEach {
            ExchangeRateTable.write([currencyPair1.code: 200.2], overwrite: true)
            exchangeRateTable = ExchangeRateTable()
          }
          it("should keep the existed exchange rate") {
            let rate = exchangeRateTable.get(for: currencyPair1)
            expect(rate) == 200.2
          }
        }
      }

      context("given the new table don't have an existed exchange rate") {
        beforeEach {
          ExchangeRateTable.write([currencyPair1.code: 100.1], overwrite: true)
          exchangeRateTable = ExchangeRateTable()
        }
        context("given overwrite is true") {
          beforeEach {
            ExchangeRateTable.write([currencyPair2.code: 30.23], overwrite: true)
            exchangeRateTable = ExchangeRateTable()
          }
          it("should keep the two exchange rates for to currency pair") {
            let rate1 = exchangeRateTable.get(for: currencyPair1)
            let rate2 = exchangeRateTable.get(for: currencyPair2)

            expect(rate1) == 100.1
            expect(rate2) == 30.23
          }
        }

        context("given overwrite is false") {
          beforeEach {
            ExchangeRateTable.write([currencyPair2.code: 15.5], overwrite: true)
            exchangeRateTable = ExchangeRateTable()
          }
          it("should keep the two exchange rates for to currency pair") {
            let rate1 = exchangeRateTable.get(for: currencyPair1)
            let rate2 = exchangeRateTable.get(for: currencyPair2)

            expect(rate1) == 100.1
            expect(rate2) == 15.5
          }
        }
      }
    }

    describe("set") {
      var exchangeRateTable: ExchangeRateTable!
      let currencyPair1 = CurrencyPair(
        source: CryptoCurrency.btc,
        target: LegalCurrency.usd
      )
      let currencyPair2 = CurrencyPair(
        source: CryptoCurrency.eth,
        target: LegalCurrency.usd
      )

      context("given a table have a currency pair") {
        beforeEach {
          ExchangeRateTable.write([currencyPair1.code: 100.1], overwrite: true)
          exchangeRateTable = ExchangeRateTable()
        }

        context("set exchange rate for a new currency pair") {
          beforeEach {
            exchangeRateTable.set(exchangeRate: 200.2, for: currencyPair2)
          }

          it("should have two key values") {
            let rate1 = exchangeRateTable.get(for: currencyPair1)
            let rate2 = exchangeRateTable.get(for: currencyPair2)

            expect(rate1) == 100.1
            expect(rate2) == 200.2
          }
        }

        context("set exchange rates for a new currency pair and a existed currency pair") {
          beforeEach {
            exchangeRateTable.set(with: [
              currencyPair1.code: 99.9,
              currencyPair2.code: 30.23,
            ])
          }

          it("should have two key values and the existed one has been updated") {
            let rate1 = exchangeRateTable.get(for: currencyPair1)
            let rate2 = exchangeRateTable.get(for: currencyPair2)

            expect(rate1) == 99.9
            expect(rate2) == 30.23
          }
        }
      }
    }
  }
}
