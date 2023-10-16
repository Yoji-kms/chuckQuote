//
//  CategoryModel.swift
//  chuckQuote
//
//  Created by Yoji on 12.10.2023.
//

import Foundation

struct Category {
    let value: String
    
    init(
        _ value: String = ""
    ) {
        self.value = value
    }
    
    init(realmModel: CategoryRealmModel) {
        self.value = realmModel.value
    }
}
