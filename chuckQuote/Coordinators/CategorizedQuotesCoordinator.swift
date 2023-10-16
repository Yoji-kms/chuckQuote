//
//  CategorizedQuotesCoordinator.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class CategorizedQuotesCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    weak var delegate: RemoveChildCoordinatorDelegate?
    
    private(set) var module: Module?
    private(set) var childCoordinators: [Coordinatable] = []
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = self.factory.makeModule(ofType: self.moduleType)
        let viewController = module.viewController
        (module.viewModel as? CategorizedQuotesViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushQuotesListController(category: Category) {
        let quotesListCoordinator = QuotesListCoordinator(moduleType: .quotesList(category), factory: self.factory)
        self.addChildCoordinator(quotesListCoordinator)
        guard let viewControllerToPush = quotesListCoordinator.start() as? QuotesListViewController else {
            return
        }
        viewControllerToPush.delegate = self.module?.viewController as? RemoveChildCoordinatorDelegate
        let navController = self.module?.viewController as? UINavigationController
        navController?.pushViewController(viewControllerToPush, animated: true)
    }
        
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
