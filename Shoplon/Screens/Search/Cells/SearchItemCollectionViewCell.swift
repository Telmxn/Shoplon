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
    
    private lazy var checkBoxView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray20.cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    private var checkBoxImageView: UIImageView = {
        let view = UIImageView()
        view.image = .checkmark
        view.tintColor = .purple100
        view.clipsToBounds = true
        view.layer.opacity = 0
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 16)
        label.textColor = .black20
        return label
    }()
    
    private var rightStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private var rightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var rightImageView: UIImageView = {
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
        [leftStackView, rightStackView].forEach(stackView.addArrangedSubview)
        [rightView, rightImageView].forEach(rightStackView.addArrangedSubview)
        [timeImageView, checkBoxView, titleLabel].forEach(leftStackView.addArrangedSubview)
        checkBoxView.addSubview(checkBoxImageView)
        
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
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        
        rightView.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(20)
        }
        
        checkBoxView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        
        checkBoxImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func subscribe(_ delegate: SearchItemDelegate) {
        self.delegate = delegate
    }
    
    @objc
    private func didTapDeleteButton() {
        if rightImageView.image == .close {
            var list = DependencyContainer.shared.userDefaultsManager.getStringArray(key: .recentSearches)
            let index = list.firstIndex { $0 == titleLabel.text }
            if let index = index {
                list.remove(at: index)
            }
            DependencyContainer.shared.userDefaultsManager.save(key: .recentSearches, value: list)
            delegate?.didDeleteItem()
        }
    }
}

extension SearchItemCollectionViewCell {
    struct Item: Hashable {
        let title: NSAttributedString
        let isDeleteButtonShown: Bool
        let isFilterItem: Bool
        let isSortItem: Bool
        let haveCheckbox: Bool
        let color: UIColor?
        let showRightImage: Bool
        
        init(title: NSAttributedString, isDeleteButtonShown: Bool) {
            self.title = title
            self.isDeleteButtonShown = isDeleteButtonShown
            self.isFilterItem = false
            self.isSortItem = false
            self.haveCheckbox = false
            self.color = nil
            self.showRightImage = isDeleteButtonShown
        }
        
        init(title: NSAttributedString, isFilterItem: Bool, haveCheckbox: Bool, showRightImage: Bool) {
            self.title = title
            self.isDeleteButtonShown = false
            self.isFilterItem = isFilterItem
            self.isSortItem = !isFilterItem
            self.haveCheckbox = haveCheckbox
            self.color = nil
            self.showRightImage = showRightImage
        }
        
        init(title: NSAttributedString, isFilterItem: Bool, color: UIColor?) {
            self.title = title
            self.isDeleteButtonShown = false
            self.isFilterItem = isFilterItem
            self.isSortItem = !isFilterItem
            self.haveCheckbox = true
            self.color = color
            self.showRightImage = false
        }
    }
    
    func configure(item: Item) {
        titleLabel.textColor = item.isDeleteButtonShown ? .black : .black20
        titleLabel.attributedText = item.title
        checkBoxView.isHidden = !item.haveCheckbox
        timeImageView.isHidden = !item.isDeleteButtonShown
        rightImageView.isHidden = !item.showRightImage
        if item.isFilterItem {
            rightImageView.snp.updateConstraints { make in
                make.size.equalTo(24)
            }
            rightImageView.image = .chevronRight
            checkBoxView.layer.cornerRadius = 6
            rightImageView.isHidden = item.haveCheckbox
            
        } else {
            rightImageView.snp.updateConstraints { make in
                make.size.equalTo(16)
            }
            rightImageView.image = .close
            checkBoxView.layer.cornerRadius = 8
        }
        
        if item.color != nil {
            rightView.backgroundColor = item.color
            rightView.isHidden = false
            if item.color == .init(hex: "#FFFFFFFF") {
                rightView.layer.borderWidth = 1
                rightView.layer.borderColor = UIColor.gray20.cgColor
            } else {
                rightView.layer.borderWidth = 0
            }
        } else {
            rightView.isHidden = true
        }
    }
}
