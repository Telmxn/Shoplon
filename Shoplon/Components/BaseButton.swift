//
//  BaseButton.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class BaseButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        configure(text: text)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .purple100
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.customFont(weight: .medium, size: 14)
        layer.cornerRadius = 12
        
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    private func configure(text: String) {
        setTitle(text, for: .normal)
    }
}
