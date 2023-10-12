//
//  Module.swift
//  chuckQuote
//
//  Created by Yoji on 06.10.2023.
//

import UIKit

struct Module {
    enum TabType {
        case randomQuote
        case quotesList
        case categorizedQuotes
    }
    
    enum ModuleType {
        case randomQuote
        case quotesList(_ category: String = Categories.all.rawValue)
        case categorizedQuotes
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let viewController: UIViewController
}

extension Module.TabType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .randomQuote:
            let title = "Random quote"
            let image = UIImage(systemName: "text.bubble") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 0)
        case .quotesList:
            let title = "Quotes list"
            let image = UIImage(systemName: "text.justify") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 1)
        case .categorizedQuotes:
            let title = "Categorized quotes"
            let image = UIImage(systemName: "square.fill.text.grid.1x2") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 2)
        }
    }
}
