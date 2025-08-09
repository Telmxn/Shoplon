//
//  ProfileViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit
import FirebaseFirestore

final class ProfileViewController: BaseViewController<ProfileViewModel> {
    private let headerView: HeaderView = {
        let view = HeaderView(icons: [.search])
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        view.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        view.register(ProfileItemCollectionViewCell.self, forCellWithReuseIdentifier: ProfileItemCollectionViewCell.identifier)
        view.register(UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "Header")
        view.contentInset = .init(top: 0, left: 0, bottom: 32, right: 0)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 40, leading: 0, bottom: 40, trailing: 0)
                return section
            } else if sectionIndex != 5 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.contentInsets = .init(top: 16, leading: 0, bottom: 32, trailing: 0)
                
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
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
//                section.contentInsets = .init(top: 16, leading: 32, bottom: 16, trailing: 32)
//                section.interGroupSpacing = 16
                return section
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData { result in
            switch result {
            case .success(let success):
                print(success)
                self.collectionView.reloadData()
            case .failure(let failure):
                self.showErrorAlertAction(message: failure.localizedDescription)
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
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return (viewModel.headerCell != nil) ? 1 : 0
        } else if section == 1 {
            return viewModel.accountCells.count
        } else if section == 2 {
            return viewModel.personalizationCells.count
        } else if section == 3 {
            return viewModel.settingsCells.count
        } else if section == 4 {
            return viewModel.helpSupportCells.count
        } else if section == 5 {
            return viewModel.logoutCells.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let headerCell = viewModel.headerCell {
                let cell: ProfileCollectionViewCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(item: headerCell)
                return cell
            }
            return UICollectionViewCell()
        } else if indexPath.section == 1 {
            let cell: ProfileItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: viewModel.accountCells[indexPath.row])
            return cell
        } else if indexPath.section == 2 {
            let cell: ProfileItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: viewModel.personalizationCells[indexPath.row])
            return cell
        } else if indexPath.section == 3 {
            let cell: ProfileItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: viewModel.settingsCells[indexPath.row])
            return cell
        } else if indexPath.section == 4 {
            let cell: ProfileItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: viewModel.helpSupportCells[indexPath.row])
            return cell
        } else if indexPath.section == 5 {
            let cell: ProfileItemCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(item: viewModel.logoutCells[indexPath.row])
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Header",
            for: indexPath
        )
        view.subviews.forEach { $0.removeFromSuperview() }
        let label = UILabel()
        
        if indexPath.section == 1 {
            label.text = "account".localized()
        } else if indexPath.section == 2 {
            label.text = "personalization".localized()
        } else if indexPath.section == 3 {
            label.text = "settings".localized()
        } else if indexPath.section == 4 {
            label.text = "helpSupport".localized()
        }
        label.font = UIFont.customFont(weight: .medium, size: 14)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            if indexPath.row == 0 {
                viewModel.logout()
            }
        }
    }
}
