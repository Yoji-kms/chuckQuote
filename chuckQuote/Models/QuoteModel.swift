//
//  Quote.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//

import Foundation

struct QuoteModel: Decodable {
    let categories: [String]
    let createdAt: String
    let id: String
    let value: String
    
    init(
        categories: [String] = [],
        createdAt: String = "",
        id: String = "",
        value: String = ""
    ) {
        self.categories = categories
        self.createdAt = createdAt
        self.id = id
        self.value = value
    }
    
    init(realmModel: QuoteRealmModel) {
        self.categories = Array(realmModel.categories)
        self.createdAt = realmModel.createdAt
        self.id = realmModel.id
        self.value = realmModel.value
    }
    
    var keyedValues: [String: Any] {
        [
            "categories": self.categories,
            "createdAt": self.createdAt,
            "id": self.id,
            "value": self.value
        ]
    }
}
