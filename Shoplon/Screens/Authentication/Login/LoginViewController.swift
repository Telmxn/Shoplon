//
//  LoginViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController, Keyboardable {
    
    var targetConstraint: Constraint?
    
    private let viewModel: LoginViewModel
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .loginHeader
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 32
        return view
    }()
    
    private let textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .medium, size: 24)
        label.textColor = .black
        label.text = "welcomeback".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "logintext".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.distribution = .fillProportionally
        return view
    }()
    
    private let tfStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillEqually
        return view
    }()
    
    private let emailTF: BaseTextField = {
        let textField = BaseTextField(logo: .mail, placeholder: "Email address")
        return textField
    }()
    
    private let passwordTF: BaseTextField = {
        let textField = BaseTextField(logo: .lock, placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple100
        label.text = "forgotpassword".localized()
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginButton: BaseButton = {
        let button = BaseButton(text: "Log in")
        return button
    }()
    
    private var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "\("dontHaveAnAccount".localized())\("signUp".localized())"
        label.textAlignment = .center
        label.halfTextColorChange(fullText: "\("dontHaveAnAccount".localized())\("signUp".localized())", changeText: "signUp".localized(), color: .purple100)
        return label
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeKeyboarGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(closeKeyboarGesture)
        
        startKeyboardObserve()
        setupUI()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            UIView.animate(withDuration: 1, delay: 0) {
                self.imageView.snp.updateConstraints { make in
                    make.height.equalTo(1)
                }
                self.stackView.snp.remakeConstraints { make in
                    make.horizontalEdges.equalToSuperview().inset(32)
                    make.top.equalTo(self.view.safeAreaLayoutGuide)
                }
                self.view.layoutIfNeeded()
            } completion: { progress in
                self.imageView.isHidden = true
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            imageView.isHidden = false
            UIView.animate(withDuration: 1) {
                self.imageView.snp.updateConstraints { make in
                    make.height.equalTo(300)
                }
                self.stackView.snp.remakeConstraints { make in
                    make.horizontalEdges.equalToSuperview().inset(32)
                    make.top.equalTo(self.imageView.snp.bottom).offset(24)
                }
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    private func setupUI() {
        view.addSubviews(imageView, stackView, loginButton, dontHaveAccountLabel)
        [textStackView, bottomStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [tfStackView, forgotPasswordLabel].forEach(bottomStackView.addArrangedSubview)
        [emailTF, passwordTF].forEach(tfStackView.addArrangedSubview)
        
        self.imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(300)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(imageView.snp.bottom).offset(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(dontHaveAccountLabel.snp.top).offset(-24).constraint
        }
        
        dontHaveAccountLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func closeKeyboard() {
        view.endEditing(true)
    }
}

