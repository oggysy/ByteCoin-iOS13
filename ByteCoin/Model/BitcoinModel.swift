//
//  BitcoinModel.swift
//  ByteCoin
//
//  Created by 小木曽佑介 on 2023/02/02.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct BitcoinModel {
    let currency: String
    var currencyName: String {
        switch currency {
        case "AUD":
            return "Australian Dollar"
        case "CAD":
            return "Canadian Dollar"
        case "CNY":
            return "Chinese Yuan"
        case "JPY":
            return "Japanese Yen"
        default:
            return "No match"
        }
    }
    let rate: Double
    var rateString: String {String(format: "%.2f", rate)}
}
