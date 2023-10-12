//
//  AppFactory.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class AppFactory {
    private let realmService: RealmService
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func makeTab(ofType tabType: Module.TabType, rootViewController: UIViewController) -> UIViewController {
            return rootViewController
    }
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .randomQuote:
            let viewModel = RandomQuoteViewModel(realmService: realmService)
            let viewController = RandomQuoteViewController(viewModel: viewModel)
            return Module(moduleType: .randomQuote, viewModel: viewModel, viewController: viewController)
        case .quotesList(let category):
            let viewModel = QuotesListViewModel(realmService: realmService, category: category)
            let viewController = QuotesListViewController(viewModel: viewModel)
            return Module(moduleType: .quotesList(), viewModel: viewModel, viewController: viewController)
        case .categorizedQuotes:
            let viewModel = CategorizedQuotesViewModel(realmService: realmService)
            let viewController = CategorizedQuotesViewController(viewModel: viewModel)
            let navController = UINavigationController(rootViewController: viewController)
            return Module(moduleType: .categorizedQuotes, viewModel: viewModel, viewController: navController)
        }
    }
}
