//
//  SignUpViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 17.06.25.
//

import UIKit
import SnapKit

final class SignUpViewController: BaseViewController<SignUpViewModel>, Keyboardable {
    
    var targetConstraint: Constraint?
    
    var imageHeight: Int? = 300
    
    var keyboardableImageView: UIImageView?
    
    private var isAgreed: Bool = false
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .signUpHeader
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
        label.text = "letsGetStarted".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "signUpText".localized()
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
    
    private var termsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var checkBoxView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray20.cgColor
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1.5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAgreeCheckBox))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private var checkBoxImageView: UIImageView = {
        let view = UIImageView()
        view.image = .checkmark
        view.tintColor = .purple100
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black40
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.text = "iAgreeTermsAndPolicy".localized()
        label.halfTextColorChange(fullText: "iAgreeTermsAndPolicy".localized(), changeText: "termsOfService".localized(), color: .purple100, font: UIFont.customFont(weight: .medium, size: 14))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTermsLabel(gesture:))))
        return label
    }()
    
    private lazy var continueButton: BaseButton = {
        let button = BaseButton(text: "continue".localized())
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var doYouHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black40
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.text = "\("doYouHaveAnAccount".localized()) \("login".localized())"
        label.textAlignment = .center
        label.halfTextColorChange(fullText: "\("doYouHaveAnAccount".localized())\("login".localized())", changeText: "login".localized(), color: .purple100, font: UIFont.customFont(weight: .medium, size: 14))
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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.signOutUser()
    }
    
    private func setupUI() {
        view.addSubviews(imageView, stackView, continueButton, doYouHaveAccountLabel)
        [textStackView, bottomStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [tfStackView, termsStackView].forEach(bottomStackView.addArrangedSubview)
        [checkBoxView, termsLabel].forEach(termsStackView.addArrangedSubview)
        checkBoxView.addSubview(checkBoxImageView)
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
        
        continueButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(doYouHaveAccountLabel.snp.top).offset(-24).constraint
        }
        
        doYouHaveAccountLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        checkBoxView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        
        checkBoxImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        checkBoxImageView.isHidden = true
    }
    
    @objc
    func tapLabel(gesture: UITapGestureRecognizer) {
        let text = "\("doYouHaveAnAccount".localized()) \("login".localized())"
        
        let signUpRange = (text as NSString).range(of: "login".localized())

        if gesture.didTapAttributedTextInLabel(label: doYouHaveAccountLabel, inRange: signUpRange) {
            viewModel.navigateToLogin()
        }
    }
    
    @objc
    func tapTermsLabel(gesture: UITapGestureRecognizer) {
        let text = "iAgreeTermsAndPolicy".localized()
        
        let signUpRange = (text as NSString).range(of: "termsOfService".localized())

        if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: signUpRange) {
            viewModel.navigateToTermsOfServices()
        }
    }
    
    @objc
    private func didTapAgreeCheckBox() {
        isAgreed.toggle()
        checkBoxView.layer.borderColor = UIColor.gray20.cgColor
        if isAgreed {
            checkBoxImageView.isHidden = false
        } else {
            checkBoxImageView.isHidden = true
        }
        view.layoutIfNeeded()
    }
    
    @objc
    private func didTapContinueButton() {
        if let email = emailTF.text?.lowercased(), !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let password = passwordTF.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if email.isValidEmail() && password.isValidPassword() {
                if isAgreed {
                    viewModel.signUpUser(with: email, password: password) { [weak self] result in
                        switch result {
                        case .success(_):
                            self?.viewModel.navigateToSetupProfile()
                        case .failure(let failure):
                            self?.emailTF.setErrorState()
                            self?.passwordTF.setErrorState()
                            self?.showErrorAlertAction(message: failure.localizedDescription)
                        }
                    }
                } else {
                    UIView.animate(withDuration: 0.3) {
                        self.checkBoxView.layer.borderColor = UIColor.red.cgColor
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
        view.layoutIfNeeded()
    }
}
