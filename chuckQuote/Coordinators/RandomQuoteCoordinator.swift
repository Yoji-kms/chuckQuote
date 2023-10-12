//
//  RandomQuoteCoordinator.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class RandomQuoteCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    private(set) var module: Module?
    private(set) var childCoordinators: [Coordinatable] = []
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = self.factory.makeModule(ofType: self.moduleType)
        let viewController = module.viewController
        (module.viewModel as? RandomQuoteViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
}
