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
    private(set) var data: [QuoteModel] = []
    private let category: String

    init(realmService: RealmService, category: String) {
        self.realmService = realmService
        self.category = category
        self.refreshData()
    }
    
    func refreshData() {
        self.realmService.getAll(model: QuoteRealmModel.self) { result in
            switch result {
            case .success(let realmQuotes):
                var allQuotes = realmQuotes.map { QuoteModel(realmModel: $0) }
                allQuotes.sort(by: { $0.createdAt >= $1.createdAt })
                switch self.category {
                case Categories.all.rawValue:
                    self.data = allQuotes
                case Categories.uncategorized.rawValue:
                    self.data = allQuotes.filter { $0.categories.isEmpty }
                default:
                    self.data = allQuotes.filter { $0.categories.contains(where: { $0 == self.category }) }
                }
            case .failure(let error):
                print("🔴\(error)")
            }
        }
    }
}
