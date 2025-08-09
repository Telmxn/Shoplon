//
//  ProfileCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.08.25.
//

import UIKit
import Kingfisher

final class ProfileCollectionViewCell: BaseCollectionViewCell {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        view.alignment = .center
        return view
    }()
    
    private let leftImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 27.5
        view.clipsToBounds = true
        return view
    }()
    
    private let textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textColor = .black
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        return label
    }()
    
    private let rightImageView: UIImageView = {
        let view = UIImageView()
        view.image = .chevronRight
        view.tintColor = .gray100
        return view
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(stackView)
        
        [leftImageView, textStackView, rightImageView].forEach(stackView.addArrangedSubview)
        
        [nameLabel, emailLabel].forEach(textStackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { make in
            make.size.equalTo(55)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
}

extension ProfileCollectionViewCell {
    struct Item {
        let leftImageUrl: String
        let name: String
        let email: String
    }
    
    func configure(item: Item) {
        leftImageView.kf.setImage(with: URL(string: item.leftImageUrl))
        nameLabel.text = "\("hi".localized()), \(item.name)"
        emailLabel.text = item.email
    }
}
