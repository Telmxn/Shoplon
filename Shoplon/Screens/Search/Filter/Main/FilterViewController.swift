//
//  FilterViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 11.07.25.
//

import UIKit

final class FilterViewController: BaseViewController<FilterViewModel> {
    
    private var diffableDataSource: FilterDiffableDataSource? = nil
    
    private var filterItemTypesList: [FilterItemType] = [
        .title(.init(title: "color".localized().highlightText(with: "color".localized()), isFilterItem: true, haveCheckbox: false, showRightImage: true)),
        .title(.init(title: "size".localized().highlightText(with: "size".localized()), isFilterItem: true, haveCheckbox: false, showRightImage: true)),
        .title(.init(title: "brand".localized().highlightText(with: "brand".localized()), isFilterItem: true, haveCheckbox: false, showRightImage: true)),
        .title(.init(title: "price".localized().highlightText(with: "price".localized()), isFilterItem: true, haveCheckbox: false, showRightImage: true)),
        .title(.init(title: "availableInStock".localized().highlightText(with: "availableInStock".localized()), isFilterItem: true, haveCheckbox: true, showRightImage: false))
    ]
    
    private var sortItemTypesList: [FilterItemType] = [
        .title(.init(title: SortBy.priceLowToHigh.rawValue.localized().highlightText(with: SortBy.priceLowToHigh.rawValue.localized()), isFilterItem: false, haveCheckbox: true, showRightImage: false)),
        .title(.init(title: SortBy.priceHightToLow.rawValue.localized().highlightText(with: SortBy.priceHightToLow.rawValue.localized()), isFilterItem: false, haveCheckbox: true, showRightImage: false)),
        .title(.init(title: SortBy.new.rawValue.localized().highlightText(with: SortBy.new.rawValue.localized()), isFilterItem: false, haveCheckbox: true, showRightImage: false)),
        .title(.init(title: SortBy.highestRated.rawValue.localized().highlightText(with: SortBy.highestRated.rawValue.localized()), isFilterItem: false, haveCheckbox: true, showRightImage: false)),
        .title(.init(title: SortBy.az.rawValue.localized().highlightText(with: SortBy.az.rawValue.localized()), isFilterItem: false, haveCheckbox: true, showRightImage: false)),
        .title(.init(title: SortBy.za.rawValue.localized().highlightText(with: SortBy.za.rawValue.localized()), isFilterItem: false, haveCheckbox: true, showRightImage: false))
    ]
    
    private var colorsItemTypesList: [FilterItemType] = []
    
    private var sizesItemTypesList: [FilterItemType] = []
    
    private var brandsItemTypesList: [FilterItemType] = []
    
    private var pricesItemTypesList: [FilterItemType] = []
    
    private let topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 9
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var filterButton: BaseButton = {
        let button = BaseButton(text: "filter".localized())
        button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortButton: BaseButton = {
        let button = BaseButton(text: "sort".localized())
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.gray20.cgColor
        button.layer.borderWidth = 1.5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        view.register(SearchItemCollectionViewCell.self, forCellWithReuseIdentifier: SearchItemCollectionViewCell.identifier)
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        view.register(UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "Header")
        view.delegate = self
        view.dataSource = diffableDataSource
        return view
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
//            let type = self?.diffableDataSource?.snapshot().sectionIdentifiers[sectionIndex]
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(52))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 32, bottom: 70, trailing: 32)
            section.interGroupSpacing = 8
            
            return section
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "filter".localized()
        
        makeDiffableDataSource()
        applySnapshot(items: filterItemTypesList, section: .filter)
        
        viewModel.fetchProducts()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(topStackView, collectionView)
        [filterButton, sortButton].forEach(topStackView.addArrangedSubview)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        filterButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(topStackView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                if products.count > 0 {
                    self?.viewModel.fetchProductColors()
                    self?.viewModel.fetchProductSizes()
                    self?.viewModel.fetchProductBrands()
                    self?.viewModel.fetchProductPrices()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$productColors
            .receive(on: DispatchQueue.main)
            .sink { colors in
                self.colorsItemTypesList = colors.map({ color in
                    let title = "\(color.key.name) (\(color.value))"
                    let productColor: UIColor? = .init(hex: color.key.hex)
                    return .title(.init(title: title.highlightText(with: color.key.name), isFilterItem: true, color: productColor))
                })
            }
            .store(in: &cancellables)
        
        viewModel.$productSizes
            .receive(on: DispatchQueue.main)
            .sink { sizes in
                self.sizesItemTypesList = sizes.map({ size in
                    let title = "\(size.key) (\(size.value))"
                    return .title(.init(title: title.highlightText(with: size.key), isFilterItem: true, haveCheckbox: true, showRightImage: false))
                })
            }
            .store(in: &cancellables)
        
        viewModel.$productBrands
            .receive(on: DispatchQueue.main)
            .sink { brands in
                self.brandsItemTypesList = brands.map({ brand in
                    let title = "\(brand.key) (\(brand.value))"
                    return .title(.init(title: title.highlightText(with: brand.key), isFilterItem: true, haveCheckbox: true, showRightImage: false))
                })
            }
            .store(in: &cancellables)
        
        viewModel.$productPrices
            .receive(on: DispatchQueue.main)
            .sink { prices in
                self.pricesItemTypesList = prices.map({ price in
                    let title = "\(price.key) (\(price.value))"
                    return .title(.init(title: title.highlightText(with: price.key), isFilterItem: true, haveCheckbox: true, showRightImage: false))
                })
            }
            .store(in: &cancellables)
    }
    
    private func makeDiffableDataSource() {
        diffableDataSource = FilterDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .title(let item):
                let cell: SearchItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(item: item)
                return cell
            }
        }
    }
    
    private func applySnapshot(items: [FilterItemType], section: FilterSection) {
        var snapshot = FilterDiffableSnapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        title = section.rawValue.localized()
        diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    @objc
    private func didTapSortButton() {
        applySnapshot(items: sortItemTypesList, section: .sort)
        setActive(button: sortButton)
        setInactive(button: filterButton)
    }
    
    @objc
    private func didTapFilterButton() {
        applySnapshot(items: filterItemTypesList, section: .filter)
        setActive(button: filterButton)
        setInactive(button: sortButton)
        
    }
    
    private func setInactive(button: BaseButton) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.gray20.cgColor
            button.layer.borderWidth = 1.5
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    private func setActive(button: BaseButton) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = .purple100
            button.layer.borderWidth = 0
            button.setTitleColor(.white, for: .normal)
        }
    }
}

typealias FilterDiffableDataSource = UICollectionViewDiffableDataSource<FilterSection, FilterItemType>
typealias FilterDiffableSnapshot = NSDiffableDataSourceSnapshot<FilterSection, FilterItemType>

enum FilterSection: String {
    case filter = "filter"
    case color = "color"
    case size = "size"
    case brand = "brand"
    case price = "price"
    case sort = "sort"
}

enum FilterItemType: Hashable {
    case title(SearchItemCollectionViewCell.Item)
}

extension FilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = diffableDataSource?.snapshot().sectionIdentifiers[indexPath.section]
        if let sectionType = sectionType, sectionType == .filter {
            if let item = diffableDataSource?.snapshot().itemIdentifiers(inSection: sectionType)[indexPath.row] {
                switch item {
                case .title(let item):
                    if item.title.string == "color".localized() {
                        applySnapshot(items: colorsItemTypesList, section: .color)
                    } else if item.title.string == "size".localized() {
                        applySnapshot(items: sizesItemTypesList, section: .size)
                    } else if item.title.string == "brand".localized() {
                        applySnapshot(items: brandsItemTypesList, section: .brand)
                    } else if item.title.string == "price".localized() {
                        applySnapshot(items: pricesItemTypesList, section: .price)
                    }
                }
            }
        }
    }
}
