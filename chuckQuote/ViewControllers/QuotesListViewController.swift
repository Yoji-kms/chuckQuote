//
//  QuotesListViewController.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class QuotesListViewController: UIViewController {
    private let viewModel: QuotesListViewModelProtocol
    weak var delegate: RemoveChildCoordinatorDelegate?
    
    private lazy var tableView: UITableView = {
        let tblView = UITableView(frame: .zero, style: .plain)
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tblView.estimatedRowHeight = 100
        tblView.dataSource = self
        tblView.translatesAutoresizingMaskIntoConstraints = false
        
        return tblView
    }()
    
//    MARK: Inits
    init(viewModel: QuotesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: Lifcycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let coordinator = (self.viewModel as? QuotesListViewModel)?.coordinator else {
            return
        }
        delegate?.remove(childCoordinator: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupViews()
    }
    
//    MARK: Setups
    private func setupViews() {
        self.view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
//    MARK: Methods
    private func refreshData() {
        self.viewModel.refreshData()
        tableView.reloadData()
    }
}

//      MARK: Extensions
extension QuotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let quote = self.viewModel.data[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = quote.value
        content.secondaryText = quote.createdAt
        cell.contentConfiguration = content
        return cell
    }
}
