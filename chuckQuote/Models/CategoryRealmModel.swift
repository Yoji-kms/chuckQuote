//
//  CategoryRealmModel.swift
//  chuckQuote
//
//  Created by Yoji on 12.10.2023.
//

import Foundation
import RealmSwift

final class CategoryRealmModel: Object {
    @Persisted(primaryKey: true) var value: String
    @Persisted(originProperty: "categories") var quotes: LinkingObjects<QuoteRealmModel>
    
    convenience init(_ value: String) {
        self.init()
        self.value = value
    }
}
