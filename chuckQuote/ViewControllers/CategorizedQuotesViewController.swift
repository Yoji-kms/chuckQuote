//
//  CategorizedQuotesViewController.swift
//  chuckQuote
//
//  Created by Yoji on 09.10.2023.
//

import UIKit

final class CategorizedQuotesViewController: UIViewController {
    private let viewModel: CategorizedQuotesViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let tblView = UITableView(frame: .zero, style: .plain)
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tblView.estimatedRowHeight = 50
        tblView.dataSource = self
        tblView.delegate = self
        tblView.translatesAutoresizingMaskIntoConstraints = false
        
        return tblView
    }()
    
//    MARK: Inits
    init(viewModel: CategorizedQuotesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
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
extension CategorizedQuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let category = self.viewModel.data[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = category
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension CategorizedQuotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        let category = self.viewModel.data[indexPath.row]
        self.viewModel.updateState(viewInput: .categoryDidTap(category))
    }
}

extension CategorizedQuotesViewController: RemoveChildCoordinatorDelegate {
    func remove(childCoordinator: Coordinatable) {
        self.viewModel.updateState(viewInput: .didReturnFromChildViewController(childCoordinator))
    }
}
