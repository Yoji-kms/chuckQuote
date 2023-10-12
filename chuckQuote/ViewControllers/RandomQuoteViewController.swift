//
//  RandomQuoteViewController.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class RandomQuoteViewController: UIViewController {
    private let viewModel: RandomQuoteViewModelProtocol
    
    private lazy var quoteLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var generateQuoteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate quote", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(generateQuoteBtnDidTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
//    MARK: Inits
    init(viewModel: RandomQuoteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupViews()
    }
    
//    MARK: Setups
    private func setupViews() {
        self.view.addSubview(self.quoteLbl)
        self.view.addSubview(self.generateQuoteBtn)
        
        NSLayoutConstraint.activate([
            self.quoteLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.quoteLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.quoteLbl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.generateQuoteBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.generateQuoteBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.generateQuoteBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            self.generateQuoteBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
//    MARK: Actions
    @objc private func generateQuoteBtnDidTap() {
        Task {
            let quote = await viewModel.updateStateNet(task: .generateQuoteBtnDidTap)
            quoteLbl.text = "Random quote: \n\n\(quote?.value ?? "")"
        }
    }
}
