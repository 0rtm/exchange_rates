//
//  Currency.swift
//  exchangeRates
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation

struct CurrencyRate: Decodable {
    
    let name: String
    let value: Float

    init(name: String, value: Float) {
        self.name = name
        self.value = value
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        name = try container.decode(String.self)
        value = try container.decode(Float.self)
    }
}

struct ExchangeRates: Decodable {
    let base: String
    let rates: [String: Float]

    var _rates: [CurrencyRate] {
        return rates.map {  CurrencyRate(name: $0, value: $1) }
    }

    var baseRate: CurrencyRate {
        return CurrencyRate(name: base, value: 1.0)
    }
}
