//
//  TabCoordinator.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class TabCoordinator: Coordinatable {
    private(set) var childCoordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let randomQuoteTabCoordinator = RandomQuoteTabCoordinator(tabType: .randomQuote, factory: factory)
        let quotesListTabCoordinator = QuotesListTabCoordinator(tabType: .quotesList, factory: factory)
        let categorizedQuotesTabCoordintor = CategorizedQuotesTabCoordinator(tabType: .categorizedQuotes, factory: factory)
        
        let appTabBarController = TabBarController(viewControllers: [
            randomQuoteTabCoordinator.start(),
            quotesListTabCoordinator.start(),
            categorizedQuotesTabCoordintor.start()
        ])
        
        addChildCoordinator(randomQuoteTabCoordinator)
        addChildCoordinator(quotesListTabCoordinator)
        addChildCoordinator(categorizedQuotesTabCoordintor)
        
        return appTabBarController
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 === coordinator }
    }
}

