//
//  CategorizedQuotesViewModel.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

final class CategorizedQuotesViewModel: CategorizedQuotesViewModelProtocol {
    var coordinator: CategorizedQuotesCoordinator?
    private(set) var data: [String] = [Categories.uncategorized.rawValue]
    private let realmService: RealmService
    
    enum ViewInput {
        case categoryDidTap(String)
        case didReturnFromChildViewController(Coordinatable)
    }
    
    init(realmService: RealmService) {
        self.realmService = realmService
        self.refreshData()
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .categoryDidTap(let category):
            self.coordinator?.pushQuotesListController(category: category)
        case .didReturnFromChildViewController(let childCoordinator):
            self.coordinator?.removeChildCoordinator(childCoordinator)
        }
    }
    
    func refreshData() {
        self.realmService.getAll(model: QuoteRealmModel.self) { result in
            switch result {
            case .success(let realmQuotes):
                let quotes = realmQuotes.map { QuoteModel(realmModel: $0) }
                quotes.forEach { quote in
                    quote.categories.forEach { category in
                        if (!self.data.contains(category)) {
                            self.data.append(category)
                        }
                    }
                }
                print(self.data)
            case .failure(let error):
                print("🔴\(error)")
            }
        }
    }
}
