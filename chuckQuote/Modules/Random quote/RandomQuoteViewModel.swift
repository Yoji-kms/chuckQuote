//
//  RandomQuoteViewModel.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation
import RealmSwift

final class RandomQuoteViewModel: RandomQuoteViewModelProtocol {
    var coordinator: RandomQuoteCoordinator?
    let realmService: RealmService
    
    enum NetworkHandle {
        case generateQuoteBtnDidTap
    }
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func updateStateNet(task: NetworkHandle) async -> Quote? {
        switch task {
        case .generateQuoteBtnDidTap:
            guard let netQuote = await NetworkService.request() as? QuoteNetModel else {
                return Quote()
            }
            let categories = netQuote.categories.map { CategoryRealmModel($0) }
            
            let realmQuote = QuoteRealmModel(
                categories: categories,
                createdAt: netQuote.createdAt,
                value: netQuote.value,
                realmService: self.realmService)
            
            self.realmService.add(object: realmQuote, keyValue: realmQuote.value) {_ in}
            
            let quote = Quote(realmModel: realmQuote)
            
            return quote
        }
    }
}
