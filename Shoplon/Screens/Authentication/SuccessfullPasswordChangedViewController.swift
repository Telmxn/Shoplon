//
//  SuccessfullPasswordChangedViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 10.06.25.
//

import UIKit

final class SuccessfullPasswordChangedViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 64
        view.alignment = .center
        return view
    }()
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.image = .passwordRecovery
        return view
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.text = "passwordSucessfullText".localized()
        label.numberOfLines = 0
        label.font = UIFont.customFont(weight: .medium, size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginButton: BaseButton = {
        let button = BaseButton(text: "login".localized())
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(stackView, loginButton)
        [imageView, textLabel].forEach(stackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(250)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
    }
    
    @objc
    private func didTapLoginButton() {
        let vc = LoginBuilder().build()
        navigationController?.setViewControllers([vc], animated: true)
    }
    
}
