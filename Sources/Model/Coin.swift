//
//  Coin.swift
//
//
//  Created by Chatsopon.d on 30/4/24.
//

import Foundation

public struct Coin: Decodable {
    public let uuid: String
    public let symbol: String
    public let name: String
    public let price: Double
    
    enum CodingKeys: CodingKey {
        case uuid
        case symbol
        case name
        case price
    }
    
    public init(uuid: String, symbol: String, name: String, price: Double) {
        self.uuid = uuid
        self.symbol = symbol
        self.name = name
        self.price = price
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        let price = Double(try container.decode(String.self, forKey: .price)) ?? 0
        self.price = price + Double.random(in: -2...2)
    }
}

extension Coin: Identifiable {
    public var id: String { uuid }
}
