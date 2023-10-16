//
//  Quote.swift
//  chuckQuote
//
//  Created by Yoji on 13.10.2023.
//

import Foundation

struct Quote {
    let createdAt: String
    let value: String
    
    init(
        createdAt: String = "",
        value: String = ""
    ) {
        self.createdAt = createdAt
        self.value = value
    }
    
    init(realmModel: QuoteRealmModel) {
        self.createdAt = realmModel.createdAt
        self.value = realmModel.value
    }
}
