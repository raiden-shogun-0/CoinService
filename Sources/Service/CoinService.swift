//
//  CoinService.swift
//
//
//  Created by Chatsopon.d on 30/4/24.
//

import Foundation
import os

public struct CoinService {
    let logger = Logger(subsystem: "com.coinservice", category: String(describing: Self.self))
    let baseURL = URL(string: "https://api.coinranking.com/v2")!
    public init() {}
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }
}
