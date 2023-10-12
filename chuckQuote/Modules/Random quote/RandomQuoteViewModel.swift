//
//  RandomQuoteViewModel.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

final class RandomQuoteViewModel: RandomQuoteViewModelProtocol {
    var coordinator: RandomQuoteCoordinator?
    let realmService: RealmService
    
    enum NetworkHandle {
        case generateQuoteBtnDidTap
    }
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func updateStateNet(task: NetworkHandle) async -> QuoteModel? {
        switch task {
        case .generateQuoteBtnDidTap:
            guard let quote = await NetworkService.request() as? QuoteModel else {
                return QuoteModel()
            }
            
            let realmQuote = QuoteRealmModel(value: quote.keyedValues)
            self.realmService.getAll(model: QuoteRealmModel.self) { result in
                switch result {
                case .success(let realmQuotes):
                    if (!realmQuotes.contains(where: { $0.value == realmQuote.value })) {
                        self.realmService.add(object: realmQuote) {_ in }
                    }
                case .failure(let error):
                    print("🔴\(error)")
                }
            }
            
            return quote
        }
    }
}
