//
//  DiscoverViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

final class DiscoverViewController: BaseViewController<DiscoverViewModel> {
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(icons: [.notification, .message])
        return view
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.addTarget(self, action: #selector(didTapSearch), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(DiscoverCategoryTableViewCell.self, forCellReuseIdentifier: DiscoverCategoryTableViewCell.identifier)
        return tableView
    }()
    
    private var categoriesList: [DiscoverCategoryTableViewCell.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchCategories { result in
            switch result {
            case .success(let categories):
                self.categoriesList = categories.map { category in
                    return .init(id: category.id, imageUrl: category.imageUrl, title: category.name)
                }
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorAlertAction(message: error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.addSubviews(headerView, searchTextField, tableView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(headerView.snp.bottom).offset(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    @objc
    private func didTapSearch() {
        viewModel.showSearch(inputData: .init(text: searchTextField.text ?? ""))
    }
}

extension DiscoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DiscoverCategoryTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.configure(item: categoriesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label: UILabel = {
            let label = UILabel()
            label.font = UIFont.customFont(weight: .medium, size: 14)
            label.textColor = .black
            label.text = "categories".localized()
            return label
        }()
        view.addSubview(label)
        view.backgroundColor = .white
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.verticalEdges.equalToSuperview().inset(16)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToCategory(inputData: .init(categoryId: categoriesList[indexPath.row].id, categoryName: categoriesList[indexPath.row].title))
    }
}
