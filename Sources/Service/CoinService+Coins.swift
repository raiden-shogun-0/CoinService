//
//  CoinService+Coins.swift
//
//
//  Created by Chatsopon.d on 30/4/24.
//

import Foundation
import os

struct CoinsResponse: Decodable {
    let status: String
    let data: CoinDataResponse
    
    struct CoinDataResponse: Decodable {
        let coins: [Coin]
    }
}

public extension CoinService {
    func coins(limit: Int = 10,
               offset: Int = 0,
               search: String = "") async throws -> [Coin] {
        let queries: [URLQueryItem] = [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)"),
            .init(name: "search", value: "\(search)"),
            .init(name: "order", value: "price")
        ]
        let coinsURL = baseURL
            .appending(path: "coins")
            .appending(queryItems: queries)
        let request = URLRequest(url: coinsURL)
        let (data, urlResponse) = try await session.data(for: request)
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            logger.log(level: .error, "Status code != 200")
            throw URLError(.badServerResponse)
        }
        
        let jsonDecoder = JSONDecoder()
        guard let coinsResponse = try? jsonDecoder.decode(CoinsResponse.self, from: data) else {
            logger.log(level: .error, "Cannot decode the data")
            throw URLError(.cannotDecodeRawData)
        }
        
        let coins = coinsResponse.data.coins
        logger.log("Received coins: \(coins)")
        return coins
    }
}
