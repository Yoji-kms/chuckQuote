//
//  CategorizedQuotesViewModelProtocol.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

protocol CategorizedQuotesViewModelProtocol: ViewModelProtocol {
    var data: [String] { get }
    func updateState(viewInput: CategorizedQuotesViewModel.ViewInput)
    func refreshData()
}
