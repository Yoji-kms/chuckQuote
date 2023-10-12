//
//  ModuleCoordinatable.swift
//  chuckQuote
//
//  Created by Yoji on 06.10.2023.
//

import Foundation

protocol ModuleCoordinatable: Coordinatable {
    var module: Module? { get }
    var moduleType: Module.ModuleType { get }
}
