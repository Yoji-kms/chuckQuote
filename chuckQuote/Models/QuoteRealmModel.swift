//
//  QuoteRealmModel.swift
//  chuckQuote
//
//  Created by Yoji on 10.10.2023.
//

import Foundation
import RealmSwift

final class QuoteRealmModel: Object {
    @Persisted var categories: List<CategoryRealmModel>
    @Persisted var createdAt: String
    @Persisted(primaryKey: true) var value: String
    
    convenience init(
        categories: [CategoryRealmModel],
        createdAt: String,
        value: String,
        realmService: RealmService
    ) {
        self.init()
        self.appendCategories(categories, realmService: realmService)
        self.createdAt = createdAt
        self.value = value
    }
    
    private func appendCategories(_ categories: [CategoryRealmModel], realmService: RealmService) {
        if categories.isEmpty {
            let uncategorized = Categories.uncategorized.rawValue
            self.appendCategory(keyValue: uncategorized, realmService: realmService)
        } else {
            categories.forEach { category in
                self.appendCategory(keyValue: category.value, realmService: realmService)
            }
        }
    }
    
    private func appendCategory(keyValue: String, realmService: RealmService) {
        realmService.getObjectByKeyValue(
            model: CategoryRealmModel.self,
            keyValue: keyValue) { result in
                switch result {
                case .success(let category):
                    if let unwrappedCategory = category {
                        self.categories.append(unwrappedCategory)
                    } else {
                        let realmCategory = CategoryRealmModel(keyValue)
                        realmService.add(object: realmCategory, keyValue: keyValue) {_ in
                            self.categories.append(realmCategory)
                        }
                    }
                case .failure(let error):
                    print("🔴\(error)")
                }
            }
    }
}
