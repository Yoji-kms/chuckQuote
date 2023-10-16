//
//  QuotesListViewModel.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

final class QuotesListViewModel: QuotesListViewModelProtocol {
    var coordinator: QuotesListCoordinator?
    private var realmService: RealmService
    private(set) var data: [Quote] = []
    private let category: Category?

    init(realmService: RealmService, category: Category?) {
        self.realmService = realmService
        self.category = category
        self.refreshData()
    }
    
    func refreshData() {
        if let unwrappedCategory = self.category {
            self.realmService.getObjectByKeyValue(
                model: CategoryRealmModel.self,
                keyValue: unwrappedCategory.value
            ) { result in
                switch result {
                case .success(let netCategory):
                    if let unwrappedNetCategory = netCategory {
                        let quotes: [Quote] = unwrappedNetCategory.quotes.map { Quote(realmModel: $0) }
                        self.data = quotes
                    } else {
                        self.data = []
                    }
                case .failure(let error):
                    print("🔴\(error)")
                }
            }
        } else {
            self.realmService.getAll(model: QuoteRealmModel.self) { result in
                switch result {
                case .success(let realmQuotes):
                    self.data = realmQuotes.map { Quote(realmModel: $0) }
                case .failure(let error):
                    print("🔴\(error)")
                }
            }
        }
    }
}
