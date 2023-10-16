//
//  Quote.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//

import Foundation

struct QuoteNetModel: Decodable {
    let categories: [String]
    let createdAt: String
    let value: String
    
    init(
        categories: [String] = [],
        createdAt: String = "",
        value: String = ""
    ) {
        self.categories = categories
        self.createdAt = createdAt
        self.value = value
    }
}
