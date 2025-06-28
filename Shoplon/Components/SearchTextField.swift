//
//  SearchTextField.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

class SearchTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 58)

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
        view.image = .search
        return view
    }()
    
    private let rightStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    private lazy var filterImageView: UIImageView = {
        let view = UIImageView()
        view.image = .filter
        view.tintColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFilterButton))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        self.placeholder = "findSomething".localized()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.borderColor = UIColor.gray20.cgColor
        layer.borderWidth = 1.5
        backgroundColor = .white
        layer.cornerRadius = 12
        addSubviews(imageView, rightStackView)
        [lineView, filterImageView].forEach(rightStackView.addArrangedSubview)
        
        
        
        font = UIFont.customFont(weight: .regular, size: 14)
        
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(1.5)
            make.verticalEdges.equalToSuperview()
        }
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(16)
        }
        
        filterImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    @objc
    func didTapFilterButton() {
        print("Tapped")
    }
}
