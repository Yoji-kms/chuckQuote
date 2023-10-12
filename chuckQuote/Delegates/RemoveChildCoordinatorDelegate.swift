//
//  RemoveChildCoordinatorDelegate.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

protocol RemoveChildCoordinatorDelegate: AnyObject {
    func remove(childCoordinator: Coordinatable)
}
