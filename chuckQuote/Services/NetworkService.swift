//
//  NetworkService.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//

import Foundation

final class NetworkService {
    static func request() async -> Any? {
        let url = "https://api.chucknorris.io/jokes/random"
        let quote: QuoteModel? = await url.handleAsDecodable()
        return quote
    }
}
