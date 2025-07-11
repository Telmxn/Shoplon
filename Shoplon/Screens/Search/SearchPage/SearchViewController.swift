//
//  SearchViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 08.07.25.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController<SearchViewModel>, Keyboardable {
    
    var targetConstraint: Constraint?
    
    var imageHeight: Int?
    
    var keyboardableImageView: UIImageView?
    
    private var diffableDataSource: DiffableDataSource? = nil
    
    private var recentSearchesList: [SearchItemType] = []
    
    private var productList: [SearchItemType] = []
    
    private var searchedProductCount: Int = 0
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(icons: [.close])
        view.subscribe(self)
        return view
    }()
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.searchTF.addTarget(self, action: #selector(didStartSearching), for: .editingChanged)
        view.searchTF.addTarget(self, action: #selector(startedWriting), for: .editingDidBegin)
        view.searchTF.addTarget(self, action: #selector(stoppedWriting), for: .editingDidEnd)
        return view
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
    
    private var searchSnapshot: DiffableSnapshot = {
        var snapshot = DiffableSnapshot()
        snapshot.appendSections([.search])
        return snapshot
    }()
    
    private var searchResultSnapshot: DiffableSnapshot = {
        var snapshot = DiffableSnapshot()
        snapshot.appendSections([.result])
        return snapshot
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let type = self?.diffableDataSource?.snapshot().sectionIdentifiers[sectionIndex]
            if  type == .recent || type == .search {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(56))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 32, bottom: 16, trailing: 32)
                section.interGroupSpacing = 8
                
                if self?.diffableDataSource?.snapshot().sectionIdentifiers[sectionIndex].rawValue == SearchSection.recent.rawValue {
                    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(18))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                    section.boundarySupplementaryItems = [header]
                }
                
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
    
    private lazy var searchButton: BaseButton = {
        let button = BaseButton(text: "search".localized())
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchTF.becomeFirstResponder()
        startKeyboardObserve()
        
        setRecentSearches()
        
        makeDiffableDataSource()
        applySnapshot()
        setupUI()
        
        viewModel.fetchProductTitles { [weak self] result in
            switch result {
            case .success(let success):
                var list: [SearchItemType] = success.map { product in
                    return .title(.init(title: product.name.highlightText(with: ""), isDeleteButtonShown: false))
                }
                let productsList: [SearchItemType] = success.map { product in
                    return .product(.init(name: product.name, price: product.price, discount: product.discount, brand: product.brand, imageUrl: product.imageUrls.first ?? ""))
                }
                list.append(contentsOf: productsList)
                
                self?.productList.append(contentsOf: list)
            case .failure(let failure):
                self?.showErrorAlertAction(message: failure.localizedDescription)
            }
        }
    }
    
    private func setRecentSearches() {
        recentSearchesList = DependencyContainer.shared.userDefaultsManager.getStringArray(key: .recentSearches).map({ text in
            return .title(.init(title: text.highlightText(with: ""), isDeleteButtonShown: true))
        })
    }
    
    private func makeDiffableDataSource() {
        diffableDataSource = DiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .title(let item):
                let cell: SearchItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(item: item)
                cell.subscribe(self)
                return cell
            case .product(let item):
                let cell: ProductCollectionViewCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(item: item)
                return cell
            }
        }
        
        diffableDataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
                
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "Header",
                for: indexPath
            )
            
            headerView.subviews.forEach { $0.removeFromSuperview() }
            let label = UILabel()
            let type = self?.diffableDataSource?.snapshot().sectionIdentifiers[indexPath.section]
            
            
            label.font = UIFont.customFont(weight: .medium, size: 14)
            label.textColor = .black
            if type == .result {
                let fulltext = "\(type?.rawValue.localized() ?? "searchResult".localized()) (\(self?.searchedProductCount ?? 0) \("items".localized()))"
                label.halfTextColorChange(fullText: fulltext, changeText: "(\(self?.searchedProductCount ?? 0) \("items".localized()))", color: .black40, font: UIFont.customFont(weight: .regular, size: 14))
            } else {
                label.text = type?.rawValue.localized()
            }
            headerView.addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            return headerView
        }
    }
    
    private func applySnapshot() {
        var snapshot = DiffableSnapshot()
        if recentSearchesList.count > 0 {
            snapshot.appendSections([.recent])
            snapshot.appendItems(recentSearchesList, toSection: .recent)
            diffableDataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    private func setupUI() {
        view.addSubviews(headerView, searchView, collectionView, searchButton)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        searchView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(headerView.snp.bottom).offset(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24).constraint
        }
    }
    
    @objc
    private func didStartSearching() {
        let searchText = searchView.searchTF.text ?? ""
        let filteredResult = productList.filter { itemType in
            switch itemType {
            case .title(let item):
                item.title.string.lowercased().contains(searchText.lowercased())
            case .product(_):
                false
            }
        }
        searchSnapshot.deleteSections([.search])
        searchSnapshot.appendSections([.search])
        
        let highlightedItems = filteredResult.map { itemType -> SearchItemType in
                switch itemType {
                case .title(let item):
                    let highlightedTitle = item.title.string.highlightText(with: searchText)
                    return .title(SearchItemCollectionViewCell.Item(title: highlightedTitle, isDeleteButtonShown: false))
                case .product(let item):
                    return .product(item)
                }
            }
        
        searchSnapshot.appendItems(highlightedItems, toSection: .search)
        diffableDataSource?.apply(searchSnapshot, animatingDifferences: true)
        if searchText.isEmpty {
            applySnapshot()
        }
    }
    
    @objc
    private func didTapSearchButton() {
        if let searchText = searchView.searchTF.text, searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            setSearchesList(text: searchText)
            
            setSearchResult(text: searchText)
        }
    }
    
    private func setSearchResult(text: String) {
        let filteredResult = productList.filter { itemType in
            switch itemType {
            case .title(_):
                return false
            case .product(let item):
                return item.name.lowercased().contains(text.lowercased())
            }
        }
        
        searchedProductCount = filteredResult.count
        
        searchResultSnapshot.deleteSections([.result])
        searchResultSnapshot.appendSections([.result])
        
        searchResultSnapshot.appendItems(filteredResult, toSection: .result)
        diffableDataSource?.apply(searchResultSnapshot, animatingDifferences: true)
    }
    
    private func setSearchesList(text: String) {
        var list: [String] = recentSearchesList.compactMap { searchItem in
            switch searchItem {
            case .title(let item):
                return item.title.string
            case .product(_):
                break
            }
            return nil
        }
        
        if list.contains(text) {
            let index = list.firstIndex { $0 == text}
            if let index = index {
                list.remove(at: index)
                list.insert(text, at: 0)
            }
            recentSearchesList = list.map({ text in
                return .title(.init(title: text.highlightText(with: ""), isDeleteButtonShown: true))
            })
        } else {
            recentSearchesList.insert(.title(.init(title: text.highlightText(with: ""), isDeleteButtonShown: true)), at: 0)
            list.insert(text, at: 0)
        }
        
        DependencyContainer.shared.userDefaultsManager.save(key: .recentSearches, value: list)
    }
    
    @objc
    private func startedWriting() {
        UIView.animate(withDuration: 0.3) {
            self.searchView.searchTF.layer.borderColor = UIColor.purple100.cgColor
            self.searchButton.alpha = 1
        }
    }
    
    @objc
    private func stoppedWriting() {
        UIView.animate(withDuration: 0.3) {
            self.searchView.searchTF.layer.borderColor = UIColor.gray20.cgColor
            self.searchButton.alpha = 0
        }
    }
}

extension SearchViewController: HeaderViewDelegate {
    func didTapCloseButton() {
        self.dismiss(animated: true)
    }
}

typealias DiffableDataSource = UICollectionViewDiffableDataSource<SearchSection, SearchItemType>
typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchItemType>

enum SearchSection: String {
    case recent = "recentSearches"
    case search = "search"
    case result = "searchResult"
}

enum SearchItemType: Hashable {
    case title(SearchItemCollectionViewCell.Item)
    case product(ProductCollectionViewCell.Item)
}

extension SearchViewController: UICollectionViewDelegate, SearchItemDelegate {
    func didDeleteItem() {
        setRecentSearches()
        applySnapshot()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = diffableDataSource?.snapshot().sectionIdentifiers[indexPath.section]
        if let sectionType = sectionType, sectionType == .recent || sectionType == .search {
            if let item = diffableDataSource?.snapshot().itemIdentifiers(inSection: sectionType)[indexPath.row] {
                switch item {
                case .title(let item):
                    setSearchesList(text: item.title.string)
                    setSearchResult(text: item.title.string)
                case .product(_):
                    break
                }
            }
        }
    }
}
