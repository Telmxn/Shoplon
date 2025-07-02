//
//  HorizontalProductCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 30.06.25.
//

import UIKit
import Kingfisher

final class HorizontalProductCollectionViewCell: BaseCollectionViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let rightStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    
    private let textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black40
        label.font = UIFont.customFont(weight: .regular, size: 8)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(weight: .medium, size: 12)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue100
        label.font = UIFont.customFont(weight: .medium, size: 12)
        return label
    }()
    
    private let freeSpaceView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.gray20.cgColor
        contentView.addSubview(stackView)
        [imageView, rightStackView].forEach(stackView.addArrangedSubview)
        [textStackView, priceStackView].forEach(rightStackView.addArrangedSubview)
        [brandLabel, nameLabel].forEach(textStackView.addArrangedSubview)
        [priceLabel, freeSpaceView].forEach(priceStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(105)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
        }
    }
}

extension HorizontalProductCollectionViewCell {
    struct Item {
        let name: String
        let price: Double
        let brand: String
        let imageUrl: String
    }
    
    func configure(item: Item) {
        nameLabel.text = item.name
        brandLabel.text = item.brand.uppercased()
        imageView.kf.setImage(with: URL(string: item.imageUrl))
        priceLabel.text = "₼\(String(format: "%.2f", item.price))"
    }
}
