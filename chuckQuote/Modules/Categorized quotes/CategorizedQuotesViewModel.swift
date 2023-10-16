//
//  CategorizedQuotesViewModel.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

final class CategorizedQuotesViewModel: CategorizedQuotesViewModelProtocol {
    var coordinator: CategorizedQuotesCoordinator?
    private(set) var data: [Category] = []
    private let realmService: RealmService
    
    enum ViewInput {
        case categoryDidTap(Category)
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
        self.realmService.getAll(model: CategoryRealmModel.self) { result in
            switch result {
            case .success(let realmCategories):
                self.data = realmCategories.map { Category(realmModel: $0) }
            case .failure(let error):
                print("🔴\(error)")
            }
        }
    }
}
