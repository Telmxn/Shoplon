//
//  ProfileItemCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.08.25.
//

import UIKit

final class ProfileItemCollectionViewCell: BaseCollectionViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        return view
    }()
    
    private let leftImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black
        return label
    }()
    
    private var rightImageView: UIImageView = {
        let view = UIImageView()
        view.image = .chevronRight
        view.tintColor = .gray100
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
        [leftImageView, titleLabel, rightImageView].forEach(stackView.addArrangedSubview)
        
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
        
        leftImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
//        rightImageView.snp.makeConstraints { make in
//            make.size.equalTo(24)
//        }
    }
}

extension ProfileItemCollectionViewCell {
    struct Item: Hashable {
        let title: String
        let leftImage: UIImage
        let isLast: Bool
        let isLogout: Bool?
        
        init(title: String, leftImage: UIImage) {
            self.title = title
            self.leftImage = leftImage
            self.isLast = false
            self.isLogout = false
        }
        
        init(title: String, leftImage: UIImage, isLast: Bool) {
            self.title = title
            self.leftImage = leftImage
            self.isLast = isLast
            self.isLogout = false
        }
        
        init(title: String, leftImage: UIImage, isLogout: Bool?) {
            self.title = title
            self.leftImage = leftImage
            self.isLogout = isLogout
            self.isLast = true
        }
    }
    
    func configure(item: Item) {
        titleLabel.text = item.title
        leftImageView.image = item.leftImage
        
        rightImageView.isHidden = item.isLogout ?? true
        
        if item.isLogout ?? false {
            titleLabel.textColor = .red100
        } else {
            titleLabel.textColor = .black
        }
        
        borderBottomView.isHidden = item.isLast
    }
}
