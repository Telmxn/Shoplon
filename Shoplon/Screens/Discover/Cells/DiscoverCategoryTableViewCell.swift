//
//  DiscoverCategoryTableViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 25.06.25.
//

import UIKit
import Kingfisher

class DiscoverCategoryTableViewCell: BaseTableViewCell {
    private let maskBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.grandisItalicFont(weight: .bold, size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubviews(logoImageView, maskBackgroundView, titleLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
        
        maskBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
}

extension DiscoverCategoryTableViewCell {
    struct Item {
        let imageUrl: String
        let title: String
    }
    
    func configure(item: Item) {
        logoImageView.kf.setImage(with: URL(string: item.imageUrl))
        titleLabel.text = item.title
    }
}
