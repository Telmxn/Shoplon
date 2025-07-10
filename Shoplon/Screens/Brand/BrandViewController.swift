//
//  BrandViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//

import UIKit

final class BrandViewController: BaseViewController<BrandViewModel> {

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        view.register(BrandHeaderCollectionViewCell.self, forCellWithReuseIdentifier: BrandHeaderCollectionViewCell.identifier)
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var mapButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple100
        view.layer.cornerRadius = 12
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapViewInMapButton))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private let mapStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let shopImageView: UIImageView = {
        let view = UIImageView()
        view.image = .shopMap
        return view
    }()
    
    private let viewInMapLabel: UILabel = {
        let label = UILabel()
        label.text = "viewInMap".localized()
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textColor = .white
        return label
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(222))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 16, leading: 32, bottom: 16, trailing: 32)
                section.interGroupSpacing = 16
                
                return section
            }
        }
    }
    
    private var brand: BrandModel?
    
    private var products: [ProductCollectionViewCell.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        
        viewModel.fetchBrand { [weak self] result in
            switch result {
            case .success(let brand):
                self?.brand = brand
                self?.title = brand.name
                self?.collectionView.reloadData()
            case .failure(let failure):
                self?.showErrorAlertAction(message: failure.localizedDescription)
            }
        }
        
        viewModel.fetchBrandProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products.map({ product in
                    return .init(name: product.name, price: product.price, discount: product.discount, brand: product.brand, imageUrl: product.imageUrls.first ?? "")
                })
                self?.collectionView.reloadData()
            case .failure(let failure):
                self?.showErrorAlertAction(message: failure.localizedDescription)
            }
        }
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(collectionView, mapButtonView)
        mapButtonView.addSubview(mapStackView)
        [shopImageView, viewInMapLabel].forEach(mapStackView.addArrangedSubview)
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        mapButtonView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.bottom.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        mapStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        shopImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    @objc
    private func didTapViewInMapButton() {
        if let name = brand?.name, let coordinate = brand?.location {
            viewModel.navigateToMap(inputData: .init(name: name, coordinates: coordinate))
        }
    }
}

extension BrandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if section == 1 { return products.count}
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: BrandHeaderCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: .init(imageUrl: brand?.logoUrl ?? "", description: brand?.description ?? ""))
            cell.subscribe(self)
            return cell
        } else if indexPath.section == 1 {
            let cell: ProductCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: products[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.3) {
                self.viewInMapLabel.isHidden = true
                self.mapButtonView.layer.cornerRadius = 28
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.viewInMapLabel.isHidden = false
                self.mapButtonView.layer.cornerRadius = 12
            }
        }
    }
}

extension BrandViewController: BrandHeaderDelegate {
    func didTapSearchField() {
        viewModel.showSearch(inputData: .init(text: ""))
    }
}
