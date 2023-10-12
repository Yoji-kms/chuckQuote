//
//  QuotesListViewModelProtocol.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

protocol QuotesListViewModelProtocol: ViewModelProtocol {
    var data: [QuoteModel] { get }
    func refreshData()
}
