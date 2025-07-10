//
//  HeaderView.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

enum HeaderIcons {
    case message
    case notification
    case search
    case close
}

protocol HeaderViewDelegate: AnyObject {
    func didTapCloseButton()
}

class HeaderView: UIView {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = .textLogo
        return view
    }()
    
    private let rightStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 24
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private let messageImageView: UIImageView = {
        let view = UIImageView()
        view.image = .message
        view.tintColor = .black
        view.isHidden = true
        return view
    }()
    
    private let notificationImageView: UIImageView = {
        let view = UIImageView()
        view.image = .bell
        view.tintColor = .black
        view.isHidden = true
        return view
    }()
    
    private lazy var closeImageView: UIImageView = {
        let view = UIImageView()
        view.image = .close
        view.tintColor = .black
        view.isHidden = true
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private let searchImageView: UIImageView = {
        let view = UIImageView()
        view.image = .search
        view.tintColor = .black
        view.isHidden = true
        return view
    }()
    
    init(icons: [HeaderIcons]) {
        super.init(frame: .zero)
        setupUI()
        configure(icons: icons)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private weak var delegate: HeaderViewDelegate?
    
    func setupUI() {
        addSubview(stackView)
        [logoImageView, rightStackView].forEach(stackView.addArrangedSubview)
        [messageImageView, notificationImageView, closeImageView, searchImageView]
            .forEach(rightStackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        messageImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        notificationImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        closeImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    func configure(icons: [HeaderIcons]) {
        icons.forEach { icon in
            switch icon {
            case .message:
                messageImageView.isHidden = false
            case .notification:
                notificationImageView.isHidden = false
            case .search:
                searchImageView.isHidden = false
            case .close:
                closeImageView.isHidden = false
            }
        }
    }
    
    func subscribe(_ delegate: HeaderViewDelegate) {
        self.delegate = delegate
    }
    
    @objc
    func didTapClose() {
        delegate?.didTapCloseButton()
    }
}
