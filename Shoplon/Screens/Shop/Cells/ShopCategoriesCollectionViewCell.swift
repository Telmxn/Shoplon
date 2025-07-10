//
//  ShopCategoriesCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.06.25.
//

import UIKit
import Kingfisher

final class ShopCategoriesCollectionViewCell: BaseCollectionViewCell {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2.5
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        view.tintColor = .black
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .medium, size: 12)
        label.textColor = .black
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.gray20.cgColor
        
        contentView.addSubview(stackView)
        [imageView, titleLabel].forEach(stackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
    }
    
    func setActive() {
        titleLabel.textColor = .white
        contentView.backgroundColor = .purple100
        contentView.layer.borderWidth = 0
        layoutIfNeeded()
    }
    
    func setNormal() {
        titleLabel.textColor = .black
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1.5
        layoutIfNeeded()
    }
}

extension ShopCategoriesCollectionViewCell {
    struct Item {
        let id: String
        let title: String
        let iconUrl: String?
        let isActive: Bool
    }
    
    func configure(item: Item) {
        titleLabel.text = item.title
        if let iconUrl = item.iconUrl {
            imageView.isHidden = false
            imageView.kf.setImage(with: URL(string: iconUrl))
        } else {
            imageView.isHidden = true
        }
        
        if item.isActive {
            setActive()
        } else {
            setNormal()
        }
    }
}
