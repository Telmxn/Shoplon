//
//  LanguageView.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class LanguageView: UIView {
    
    let language: String
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    private let leftStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 16
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    private let flagImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(weight: .regular, size: 14)
        return label
    }()
    
    private let selectedImageView: UIImageView = {
        let view = UIImageView()
        view.image = .radioButton
        return view
    }()
    
    init(language: Language, isSelected: Bool) {
        self.language = language.rawValue
        super.init(frame: .zero)
        setupUI()
        configure(language: language, isSelected: isSelected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.gray20.cgColor
        
        addSubview(stackView)
        [leftStackView, selectedImageView].forEach(stackView.addArrangedSubview)
        [flagImageView, languageLabel].forEach(leftStackView.addArrangedSubview)
        
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.size.equalTo(17)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }
    
    private func configure(language: Language, isSelected: Bool) {
        languageLabel.text = language.title
        flagImageView.image = language.flag
        selectedImageView.isHidden = true
        if isSelected {
            setSelected()
        } else {
            setUnselected()
        }
    }
    
    func setSelected() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = .purple100
            self.layer.borderWidth = 0
            self.languageLabel.textColor = .white
        }
        self.selectedImageView.isHidden = false
    }
    
    func setUnselected() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = .clear
            self.layer.borderWidth = 1.5
            self.languageLabel.textColor = .black
        }
        self.selectedImageView.isHidden = true
    }
}
