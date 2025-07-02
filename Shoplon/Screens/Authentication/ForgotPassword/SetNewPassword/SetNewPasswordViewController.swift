//
//  SetNewPasswordViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 09.06.25.
//

import UIKit
import SnapKit

final class SetNewPasswordViewController: BaseViewController<SetNewPasswordViewModel>, Keyboardable {
    var imageHeight: Int? = 230
    
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
        label.font = UIFont.customFont(weight: .medium, size: 18)
        label.textColor = .black
        label.text = "setNewPassword".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "newPasswordText".localized()
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
    
    private let newPasswordTF: BaseTextField = {
        let textField = BaseTextField(logo: .lock, placeholder: "newPassword".localized())
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let newPasswordAgainTF: BaseTextField = {
        let textField = BaseTextField(logo: .lock, placeholder: "newPasswordAgain".localized())
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(text: "changePassword".localized())
        button.addTarget(self, action: #selector(didTapChangePasswordButton), for: .touchUpInside)
        return button
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
                make.top.equalTo(self.imageView.snp.bottom).offset(63)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        view.addSubviews(imageView, stackView, nextButton)
        [textStackView, bottomStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [tfStackView].forEach(bottomStackView.addArrangedSubview)
        [newPasswordTF, newPasswordAgainTF].forEach(tfStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(imageHeight ?? 230)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(imageView.snp.bottom).offset(63)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24).constraint
        }
    }
    
    @objc
    private func didTapChangePasswordButton() {
        if let password = newPasswordTF.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let passwordAgain = newPasswordAgainTF.text, !passwordAgain.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if password == passwordAgain && password.isValidPassword() {
                viewModel.changePassword(password: password) { result in
                    switch result {
                    case .success(_):
                        self.viewModel.navigateToSuccess()
                    case .failure(let failure):
                        self.newPasswordTF.setErrorState()
                        self.newPasswordAgainTF.setErrorState()
                        self.showErrorAlertAction(message: failure.localizedDescription)
                    }
                }
            } else if password != passwordAgain && password.isValidPassword() {
                self.newPasswordAgainTF.setErrorState()
            } else {
                self.newPasswordTF.setErrorState()
                self.newPasswordAgainTF.setErrorState()
            }
        } else {
            newPasswordTF.setErrorState()
            newPasswordAgainTF.setErrorState()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
}
