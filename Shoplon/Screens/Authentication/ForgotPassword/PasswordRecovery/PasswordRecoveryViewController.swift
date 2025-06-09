//
//  PasswordRecoveryViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit
import SnapKit
import FirebaseFunctions

class PasswordRecoveryViewController: BaseViewController<PasswordRecoveryViewModel>, Keyboardable {
    var imageHeight: Int? = 250
    
    var keyboardableImageView: UIImageView?
    
    var targetConstraint: Constraint?
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .passwordRecovery
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
        label.text = "passwordRecovery".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "passwordRecoveryText".localized()
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
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(text: "next".localized())
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "\("dontHaveAnAccount".localized()) \("login".localized())"
        label.textAlignment = .center
        label.halfTextColorChange(fullText: "\("dontHaveAnAccount".localized())\("login".localized())", changeText: "login".localized(), color: .purple100, font: UIFont.customFont(weight: .medium, size: 14))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLogin))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardableImageView = imageView
        startKeyboardObserve()
        bindViewModel()
        setupUI()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            self.stackView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(32)
                make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            }
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            self.stackView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(32)
                make.top.equalTo(self.imageView.snp.bottom).offset(59)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        view.addSubviews(imageView, stackView, nextButton, dontHaveAccountLabel)
        [textStackView, bottomStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [tfStackView].forEach(bottomStackView.addArrangedSubview)
        [emailTF].forEach(tfStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(imageHeight ?? 250)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(imageView.snp.bottom).offset(59)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(dontHaveAccountLabel.snp.top).offset(-24).constraint
        }
        
        dontHaveAccountLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func didTapLogin() {
        viewModel.navigateToLogin()
    }
    
    @objc
    private func didTapNextButton() {
        if let email = emailTF.text?.lowercased(), !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if email.isValidEmail() {
                viewModel.sendOTPMail(to: email) { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.viewModel.navigateToVerificationCode(with: .init(email: email))
                    case .failure(let failure):
                        self?.emailTF.setErrorState()
                        self?.showErrorAlertAction(message: failure.localizedDescription)
                    }
                }
            } else {
                self.emailTF.setErrorState()
            }
        } else {
            emailTF.setErrorState()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
}
