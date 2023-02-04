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
    let rate: Double
    var rateString: String {String(format: "%.2f", rate)}
}
