//
//  BrandsCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.06.25.
//

import UIKit
import Kingfisher

final class BrandsCollectionViewCell: BaseCollectionViewCell {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension BrandsCollectionViewCell {
    func configure(logoUrl: String) {
        imageView.kf.setImage(with: URL(string: logoUrl))
    }
}
