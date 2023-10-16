//
//  CategorizedQuotesViewModelProtocol.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

protocol CategorizedQuotesViewModelProtocol: ViewModelProtocol {
    var data: [Category] { get }
    func updateState(viewInput: CategorizedQuotesViewModel.ViewInput)
    func refreshData()
}
