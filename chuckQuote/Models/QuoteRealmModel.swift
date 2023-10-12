//
//  QuoteRealmModel.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//

import Foundation
import RealmSwift

final class QuoteRealmModel: Object {
    @Persisted var categories: List<String>
    @Persisted var createdAt: String
    @Persisted(primaryKey: true) var id: String
    @Persisted var value: String
    
    convenience init(categories: List<String>, createdAt: String, id: String, value: String) {
        self.init()
        self.categories = categories
        self.createdAt = createdAt
        self.id = id
        self.value = value
    }
}
