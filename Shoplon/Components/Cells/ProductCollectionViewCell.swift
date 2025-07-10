//
//  ProductCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 28.06.25.
//

import UIKit
import Kingfisher

final class ProductCollectionViewCell: BaseCollectionViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let saleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red100
        view.layer.cornerRadius = 7
        return view
    }()
    
    private let saleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .medium, size: 8)
        label.textColor = .white
        label.text = "24% \("off".localized())"
        return label
    }()
    
    private let bottomStackView: UIStackView = {
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
    
    private let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 10)
        label.textColor = .gray100
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
        [imageContainerView, bottomStackView].forEach(stackView.addArrangedSubview)
        [textStackView, priceStackView].forEach(bottomStackView.addArrangedSubview)
        [brandLabel, nameLabel].forEach(textStackView.addArrangedSubview)
        [priceLabel, oldPriceLabel, freeSpaceView].forEach(priceStackView.addArrangedSubview)
        imageContainerView.addSubviews(imageView, saleView)
        saleView.addSubview(saleLabel)
        
        imageContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(108)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(16)
        }
        
        saleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        saleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(2)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}

extension ProductCollectionViewCell {
    struct Item: Hashable {
        let name: String
        let price: Double
        let discount: Double
        let brand: String
        let imageUrl: String
    }
    
    func configure(item: Item) {
        nameLabel.text = item.name
        brandLabel.text = item.brand.uppercased()
        imageView.kf.setImage(with: URL(string: item.imageUrl))
        if item.discount > 0 {
            saleView.isHidden = false
            oldPriceLabel.isHidden = false
            saleLabel.text = "\(String(format: "%.0f", item.discount))% \("off".localized())"
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "₼\(String(format: "%.2f", item.price))")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            oldPriceLabel.attributedText = attributeString
            let newPrice = item.price - (item.price * (item.discount * 0.01))
            priceLabel.text = "₼\(String(format: "%.2f", newPrice))"
        } else {
            saleView.isHidden = true
            oldPriceLabel.isHidden = true
            priceLabel.text = "₼\(String(format: "%.2f", item.price))"
        }
        layoutIfNeeded()
    }
}
