//
//  CurrencyPairSpec.swift
//  CurrencyPairSpec
//
//  Created by Facheng Liang on 2021/9/12.
//

import Nimble
import Quick
@testable import Currency

class CurrencyPairSpec: QuickSpec {

  override func spec() {
    var pair: CurrencyPair!

    describe("code") {
      context("given source is RMB and target is BTC") {
        beforeEach {
          pair = CurrencyPair(
            source: LegalCurrency.rmb,
            target: CryptoCurrency.btc("")
          )
        }

        it("should be RMB/BTC") {
          expect(pair.code) == "RMB/BTC"
        }
      }

      context("given source is ETH and target is USD") {
        beforeEach {
          pair = CurrencyPair(
            source: CryptoCurrency.eth(""),
            target: LegalCurrency.usd
          )
        }

        it("should be ETH/USD") {
          expect(pair.code) == "ETH/USD"
        }
      }
    }
  }

}
