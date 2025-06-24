//
//  SetUpPrivacyViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit
import LocalAuthentication

final class SetUpPrivacyViewController: BaseViewController<SetUpPrivacyViewModel> {
    
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
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .fingerprint
        return view
    }()
    
    private let buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private lazy var setupPrivacyButton: BaseButton = {
        let button = BaseButton(text: "setup".localized())
        button.addTarget(self, action: #selector(didTapSetupPrivacyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: BaseButton = {
        let button = BaseButton(text: "skip".localized())
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = LAContext()
        switch context.biometricType {
        case .none:
            viewModel.navigateToHome()
        case .touchID:
            titleLabel.text = "howFingerprint".localized()
            subtitleLabel.text = "fingerprintText".localized()
            setupPrivacyButton.setTitle("setupFingerprint".localized(), for: .normal)
            imageView.image = .fingerprint
        case .faceID:
            titleLabel.text = "howFaceID".localized()
            subtitleLabel.text = "faceIDText".localized()
            setupPrivacyButton.setTitle("setupFaceid".localized(), for: .normal)
            imageView.image = .faceID
        }
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(textStackView, imageView, buttonsStackView)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [setupPrivacyButton, skipButton].forEach(buttonsStackView.addArrangedSubview)
        
        textStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(250)
            make.center.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    @objc
    private func didTapSetupPrivacyButton() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self?.showErrorAlertAction(message: "Failed to Authenticate")
                        return
                    }
                    self?.viewModel.navigateToHome()
                }
            }
        } else {
            showErrorAlertAction(message: "You cannot use this feature")
        }
    }
}
