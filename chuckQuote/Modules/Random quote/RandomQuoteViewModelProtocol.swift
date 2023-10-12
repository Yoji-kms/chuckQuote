//
//  RandomQuoteViewModelProtocol.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import Foundation

protocol RandomQuoteViewModelProtocol: ViewModelProtocol {
    func updateStateNet(task: RandomQuoteViewModel.NetworkHandle) async -> QuoteModel?
}
