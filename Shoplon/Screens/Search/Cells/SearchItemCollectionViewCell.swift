//
//  SearchItemCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.07.25.
//

import UIKit

protocol SearchItemDelegate: AnyObject {
    func didDeleteItem()
}

final class SearchItemCollectionViewCell: BaseCollectionViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    private let leftStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let timeImageView: UIImageView = {
        let view = UIImageView()
        view.image = .time
        view.tintColor = .black
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 16)
        label.textColor = .black20
        return label
    }()
    
    private lazy var deleteImageView: UIImageView = {
        let view = UIImageView()
        view.image = .close
        view.tintColor = .gray100
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteButton))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let borderBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray20
        return view
    }()
    
    private weak var delegate: SearchItemDelegate?
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubviews(stackView, borderBottomView)
        [leftStackView, deleteImageView].forEach(stackView.addArrangedSubview)
        [timeImageView, titleLabel].forEach(leftStackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().inset(16)
        }
        
        borderBottomView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        
        timeImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        deleteImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }
    
    func subscribe(_ delegate: SearchItemDelegate) {
        self.delegate = delegate
    }
    
    @objc
    private func didTapDeleteButton() {
        var list = DependencyContainer.shared.userDefaultsManager.getStringArray(key: .recentSearches)
        let index = list.firstIndex { $0 == titleLabel.text }
        if let index = index {
            list.remove(at: index)
        }
        DependencyContainer.shared.userDefaultsManager.save(key: .recentSearches, value: list)
        delegate?.didDeleteItem()
    }
}

extension SearchItemCollectionViewCell {
    struct Item: Hashable {
        let title: NSAttributedString
        let isDeleteButtonShown: Bool
    }
    
    func configure(item: Item) {
        titleLabel.textColor = item.isDeleteButtonShown ? .black : .black20
        titleLabel.attributedText = item.title
        deleteImageView.isHidden = !item.isDeleteButtonShown
        timeImageView.isHidden = !item.isDeleteButtonShown
    }
}
