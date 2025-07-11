//
//  BrandHeaderCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 02.07.25.
//

import UIKit
import Kingfisher

protocol BrandHeaderDelegate: AnyObject {
    func didTapSearchField()
}

final class BrandHeaderCollectionViewCell: BaseCollectionViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 16
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let brandStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.searchTF.addTarget(self, action: #selector(didTapSearch), for: .editingDidBegin)
        return view
    }()
    
    private weak var delegate: BrandHeaderDelegate?
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubviews(stackView)
        [brandStackView, searchView].forEach(stackView.addArrangedSubview)
        [imageView, descriptionLabel].forEach(brandStackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        searchView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func subscribe(_ delegate: BrandHeaderDelegate) {
        self.delegate = delegate
    }
}

extension BrandHeaderCollectionViewCell {
    struct Item {
        let imageUrl: String
        let description: String
    }
    
    func configure(item: Item) {
        imageView.kf.setImage(with: URL(string: item.imageUrl))
        descriptionLabel.text = item.description
        layoutIfNeeded()
    }
    
    @objc
    func didTapSearch() {
        delegate?.didTapSearchField()
    }
}
