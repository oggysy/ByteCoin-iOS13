//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBitcoin(_ coinManager: CoinManager, bitcoin: BitcoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = ""
    let currencyArray = ["AUD", "CAD","CNY","JPY"]
    
    var delegate: ViewController?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, request, error in
            guard error == nil else {
                delegate?.didFailWithError(error: error!)
                return
            }
            guard let safeData = data else { return }
            guard let bitcoinData = parseJSON(safeData) else { return }
            delegate?.didUpdateBitcoin(self, bitcoin: bitcoinData)
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) ->BitcoinModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BitcoinData.self, from: data)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let bitcoin = BitcoinModel(currency: currency, rate: rate)
            return bitcoin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
