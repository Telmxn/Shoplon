//
//  ShopViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import UIKit

final class ShopViewController: BaseViewController<ShopViewModel> {
    private let headerView: HeaderView = {
        let view = HeaderView(icons: [.notification, .message])
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        view.register(ShopCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: ShopCategoriesCollectionViewCell.identifier)
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        view.register(BrandsCollectionViewCell.self, forCellWithReuseIdentifier: BrandsCollectionViewCell.identifier)
        view.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.identifier)
        view.register(HorizontalProductCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalProductCollectionViewCell.identifier)
        view.register(UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "Header")
        
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .absolute(36))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 16, leading: 32, bottom: 17, trailing: 32)
                section.interGroupSpacing = 8
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(25))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]
                return section
            } else if sectionIndex == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(141), heightDimension: .absolute(222))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 16, leading: 32, bottom: 16, trailing: 32)
                section.interGroupSpacing = 16
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(18))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]
                return section
            } else if sectionIndex == 2 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(32)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 10, leading: 32, bottom: 40, trailing: 32)
                return section
            } else if sectionIndex == 3 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 40, trailing: 0)
                return section
            } else if sectionIndex == 4 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(141), heightDimension: .absolute(222))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 16, leading: 32, bottom: 24, trailing: 32)
                section.interGroupSpacing = 16
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(18))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .absolute(114))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 16, leading: 32, bottom: 16, trailing: 32)
                section.interGroupSpacing = 16
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(18))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]
                return section
            }
        }
    }
    
    private var categoriesList: [ShopCategoriesCollectionViewCell.Item] = []
    private var allProductsList: [ProductCollectionViewCell.Item] = []
    private var popularProductsList: [HorizontalProductCollectionViewCell.Item] = []
    private var brandsLogoList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchCategories { result in
            switch result {
            case .success(let categories):
                self.categoriesList = categories.map({ category in
                    return .init(title: category.name, iconUrl: category.iconUrl, isActive: false)
                })
                self.categoriesList.insert(.init(title: "allCategories".localized(), iconUrl: nil, isActive: true), at: 0)
                self.collectionView.reloadData()
            case .failure(let error):
                self.showErrorAlertAction(message: error.localizedDescription)
            }
        }
        
        viewModel.fetchProducts { result in
            switch result {
            case .success(let products):
                self.allProductsList = products.map({ product in
                    return .init(name: product.name, price: product.price, discount: product.discount, brand: product.brand, imageUrl: product.imageUrls.first ?? "")
                })
                self.popularProductsList = products.compactMap({ product in
                    if product.discount == 0 {
                        return .init(name: product.name, price: product.price, brand: product.brand, imageUrl: product.imageUrls.first ?? "")
                    }
                    return nil
                })
                self.collectionView.reloadData()
            case .failure(let failure):
                self.showErrorAlertAction(message: failure.localizedDescription)
            }
        }
        
        viewModel.fetchBrands { result in
            switch result {
            case .success(let brands):
                self.brandsLogoList = brands.map({ brand in
                    return brand.logoUrl
                })
                self.collectionView.reloadData()
            case .failure(let error):
                self.showErrorAlertAction(message: error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.addSubviews(headerView, collectionView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return categoriesList.count }
        if section == 1 { return allProductsList.count > 4 ? 4 : allProductsList.count }
        if section == 2 { return brandsLogoList.count }
        if section == 3 { return 1 }
        if section == 4 { return allProductsList.count > 4 ? 4 : allProductsList.count }
        if section == 5 { return popularProductsList.count }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: ShopCategoriesCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: categoriesList[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            let cell: ProductCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: allProductsList[indexPath.row])
            return cell
        } else if indexPath.section == 2 {
            let cell: BrandsCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(logoUrl: brandsLogoList[indexPath.row])
            return cell
        } else if indexPath.section == 3 {
            let cell: SaleCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            return cell
        } else if indexPath.section == 4 {
            let cell: ProductCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: allProductsList[indexPath.row])
            return cell
        } else if indexPath.section == 5 {
            let cell: HorizontalProductCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: popularProductsList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Header",
            for: indexPath
        )
        view.subviews.forEach { $0.removeFromSuperview() }
        let label = UILabel()
        
        if indexPath.section == 0 {
            label.text = "categories".localized()
        } else if indexPath.section == 1 {
            label.text = "popularProducts".localized()
        } else if indexPath.section == 4 {
            label.text = "bestSellers".localized()
        } else if indexPath.section == 5 {
            label.text = "mostPopular".localized()
        }
        label.font = UIFont.customFont(weight: .medium, size: 14)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Basildi", indexPath.section)
    }
}
