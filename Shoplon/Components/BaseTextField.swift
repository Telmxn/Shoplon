//
//  BaseTextField.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class BaseTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .gray100
        return view
    }()
    
    init(logo: UIImage, placeholder: String) {
        super.init(frame: .zero)
        configure(logo: logo, placeholder: placeholder)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .gray10
        layer.cornerRadius = 12
        addSubview(imageView)
        
        font = UIFont.customFont(weight: .regular, size: 14)
        
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
    }
    
    private func configure(logo: UIImage, placeholder: String) {
        self.placeholder = placeholder
        imageView.image = logo
    }
}
