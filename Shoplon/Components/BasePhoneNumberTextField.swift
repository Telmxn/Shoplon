//
//  BasePhoneNumberTextField.swift
//  Shoplon
//
//  Created by Telman Yusifov on 20.06.25.
//

import UIKit
import PhoneNumberKit

class BasePhoneNumberTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get {
            return "AZ"
        }
        set {} // exists for backward compatibility
    }
    
    var padding = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 16)

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
    
    init(logo: UIImage?, placeholder: String?) {
        super.init(frame: .zero)
        configure(logo: logo, placeholder: placeholder)
        addTarget(self, action: #selector(setNormalState), for: .editingChanged)
        setupUI()
    }
    
    @MainActor required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.borderColor = UIColor.red.cgColor
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
    
    private func configure(logo: UIImage?, placeholder: String?) {
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        if let logo = logo {
            imageView.isHidden = false
            imageView.image = logo
        } else {
            imageView.isHidden = true
            padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    func setErrorState() {
        UIView.animate(withDuration: 0.3) {
            self.layer.borderWidth = 1
        }
    }
    
    @objc
    func setNormalState() {
        UIView.animate(withDuration: 0.3) {
            self.layer.borderWidth = 0
        }
    }
}
