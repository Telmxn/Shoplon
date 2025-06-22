//
//  LoginViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController<LoginViewModel>, Keyboardable {
    
    var keyboardableImageView: UIImageView?
    
    var imageHeight: Int? = 300
    
    var targetConstraint: Constraint?
    
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
        let textField = BaseTextField(logo: .mail, placeholder: "emailAddress".localized())
        return textField
    }()
    
    private let passwordTF: BaseTextField = {
        let textField = BaseTextField(logo: .lock, placeholder: "password".localized())
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple100
        label.text = "forgotpassword".localized()
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textAlignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapForPassword))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var loginButton: BaseButton = {
        let button = BaseButton(text: "login".localized())
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "\("dontHaveAnAccount".localized()) \("signUp".localized())"
        label.textAlignment = .center
        label.halfTextColorChange(fullText: "\("dontHaveAnAccount".localized())\("signUp".localized())", changeText: "signUp".localized(), color: .purple100, font: UIFont.customFont(weight: .medium, size: 14))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardableImageView = imageView
        startKeyboardObserve()
        setupUI()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            self.stackView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(32)
                make.top.equalTo(self.view.safeAreaLayoutGuide)
            }
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            self.stackView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(32)
                make.top.equalTo(self.imageView.snp.bottom).offset(24)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        view.addSubviews(imageView, stackView, loginButton, dontHaveAccountLabel)
        [textStackView, bottomStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [tfStackView, forgotPasswordLabel].forEach(bottomStackView.addArrangedSubview)
        [emailTF, passwordTF].forEach(tfStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(imageHeight ?? 300)
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
    private func didTapForPassword() {
        viewModel.navigateToForgotPassword()
    }
    
    @objc
    func tapLabel(gesture: UITapGestureRecognizer) {
        let text = "\("dontHaveAnAccount".localized()) \("signUp".localized())"
        
        let signUpRange = (text as NSString).range(of: "signUp".localized())

        if gesture.didTapAttributedTextInLabel(label: dontHaveAccountLabel, inRange: signUpRange) {
            viewModel.navigateToSignUp()
        }
    }
    
    @objc
    private func didTapLoginButton() {
        if let email = emailTF.text?.lowercased(), !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let password = passwordTF.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if email.isValidEmail() && password.isValidPassword() {
                viewModel.login(with: email, password: password) { [weak self] result in
                    switch result {
                    case .success(let success):
                        print("Kecdi")
                    case .failure(let failure):
                        self?.emailTF.setErrorState()
                        self?.passwordTF.setErrorState()
                        self?.showErrorAlertAction(message: failure.localizedDescription)
                    }
                }
            } else {
                self.emailTF.setErrorState()
                self.passwordTF.setErrorState()
            }
        } else {
            emailTF.setErrorState()
            passwordTF.setErrorState()
        }
    }
}

