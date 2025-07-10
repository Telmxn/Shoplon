//
//  CategoryProductsViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 27.06.25.
//

import UIKit

final class CategoryProductsViewController: BaseViewController<CategoryProductsViewModel> {
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.addTarget(self, action: #selector(didTapSearch), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(222))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(16)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 32, bottom: 16, trailing: 32)
            section.interGroupSpacing = 16
            
            return section
        }
    }
    
    private var products: [ProductCollectionViewCell.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.getCategoryName()
        
        viewModel.fetchCategoryProducts { result in
            switch result {
            case .success(let products):
                self.products = products.map({ product in
                    return .init(name: product.name, price: product.price, discount: product.discount, brand: product.brand, imageUrl: product.imageUrls.first ?? "")
                })
                self.collectionView.reloadData()
            case .failure(let failure):
                self.showErrorAlertAction(message: failure.localizedDescription)
            }
        }
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(searchTextField, collectionView)
        
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func didTapSearch() {
        viewModel.showSearch(inputData: .init(text: searchTextField.text ?? ""))
    }
}

extension CategoryProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.configure(item: products[indexPath.row])
        return cell
    }
}
