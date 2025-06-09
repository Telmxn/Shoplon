//
//  VerificationCodeViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.05.25.
//

import UIKit
import SnapKit

class VerificationCodeViewController: BaseViewController<VerificationCodeViewModel>, Keyboardable {
    var imageHeight: Int? = 280
    
    var keyboardableImageView: UIImageView?
    
    var targetConstraint: Constraint?
    
    private var email: String?
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .verificationCode
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
        label.text = "verificationCode".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.text = "sentVerificationCode".localized()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
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
        view.axis = .horizontal
        view.spacing = 13
        view.distribution = .fillEqually
        return view
    }()
    
    private let otpField0: BaseTextField = {
        let textField = BaseTextField(logo: nil, placeholder: nil)
        return textField
    }()
    
    private let otpField1: BaseTextField = {
        let textField = BaseTextField(logo: nil, placeholder: nil)
        return textField
    }()
    
    private let otpField2: BaseTextField = {
        let textField = BaseTextField(logo: nil, placeholder: nil)
        return textField
    }()
    
    private let otpField3: BaseTextField = {
        let textField = BaseTextField(logo: nil, placeholder: nil)
        return textField
    }()
    
    lazy var otpFields: [BaseTextField] = [ otpField0, otpField1, otpField2, otpField3]
    
    private let resendAfterLabel: UILabel = {
        let label = UILabel()
        label.text = "resendCodeAfter".localized()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.textAlignment = .center
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    private var resendButton: BaseButton = {
        let button = BaseButton(text: "resend".localized())
        button.layer.borderColor = UIColor.gray20.cgColor
        button.layer.borderWidth = 1.5
        button.backgroundColor = .clear
        button.setTitleColor(.gray100, for: .disabled)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private lazy var confirmButton: BaseButton = {
        let button = BaseButton(text: "confirm".localized())
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private var timer: Timer? = nil
    private var timeLeftSeconds: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardableImageView = imageView
        startKeyboardObserve()
        bindViewModel()
        setupUI()
        
        viewModel.fetchInputData { inputData in
            email = inputData.email
            let text = "\("sentVerificationCode".localized()) \(email ?? "") \("changeEmailAddress".localized())"
            subtitleLabel.text = text
            let underlineAttriString = NSMutableAttributedString(string: text)
            let range1 = (text as NSString).range(of: email ?? "")
            underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.customFont(weight: .medium, size: 14), range: range1)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
            let range2 = (text as NSString).range(of: "changeEmailAddress".localized())
            underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.customFont(weight: .medium, size: 14), range: range2)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple100, range: range2)
            subtitleLabel.attributedText = underlineAttriString
        }
        
        for (index, field) in otpFields.enumerated() {
            field.delegate = self
            field.tag = index
            field.textAlignment = .center
            field.keyboardType = .numberPad
            field.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        }
        otpField0.becomeFirstResponder()
        
        scheduleTimeLeft()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.scheduleTimeLeft()
        })
        
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
    
    private func scheduleTimeLeft() {
        self.timeLeftSeconds -= 1
        let leftMinutes = self.timeLeftSeconds%3600/60
        let leftSeconds = self.timeLeftSeconds%60
        
        resendAfterLabel.text = "\("resendCodeAfter".localized()) \(String(format: "%02d", leftMinutes)):\(String(format: "%02d", leftSeconds))"
        
        resendAfterLabel.halfTextColorChange(fullText: "\("resendCodeAfter".localized()) \(String(format: "%02d", leftMinutes)):\(String(format: "%02d", leftSeconds))", changeText: "\(String(format: "%02d", leftMinutes)):\(String(format: "%02d", leftSeconds))", color: .purple100, font: UIFont.customFont(weight: .medium, size: 14))
        
        if self.timeLeftSeconds == 0 {
            resendAfterLabel.isHidden = true
            resendButton.isEnabled = true
            self.timer?.invalidate()
        }
    }
    
    private func setupUI() {
        view.addSubviews(imageView, stackView, buttonsStackView)
        [textStackView, bottomStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        [tfStackView, resendAfterLabel].forEach(bottomStackView.addArrangedSubview)
        [otpField0, otpField1, otpField2, otpField3].forEach(tfStackView.addArrangedSubview)
        [resendButton, confirmButton].forEach(buttonsStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(imageHeight ?? 250)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(buttonsStackView.snp.top).offset(-64)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40).constraint
        }
    }
    
    @objc
    private func didTapLogin() {
        
    }
    
    @objc
    private func didTapNextButton() {
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    @objc
    func tapLabel(gesture: UITapGestureRecognizer) {
        let text = "\("sentVerificationCode".localized()) \(email ?? "") \("changeEmailAddress".localized())"
        
        let changePhoneNumberRange = (text as NSString).range(of: "changeEmailAddress".localized())

        if gesture.didTapAttributedTextInLabel(label: subtitleLabel, inRange: changePhoneNumberRange) {
            viewModel.navigateToPasswordRecovery()
        }
    }
    
    @objc
    func textDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if text.count > 1 {
            let characters = Array(text.prefix(4))
            for (i, char) in characters.enumerated() {
                otpFields[i].text = String(char)
            }
            otpFields.last?.resignFirstResponder()
            checkOTPCompletion()
            return
        }

        if text.count == 1 {
            let nextTag = textField.tag + 1
            if nextTag < otpFields.count {
                otpFields[nextTag].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                checkOTPCompletion()
            }
        }
    }
    
    func checkOTPCompletion() {
        let otp = otpFields.reduce("") { partialResult, textField in
            let text = textField.text ?? ""
            return partialResult + text
        }
        if otp.count == 4 {
            viewModel.verifyOTP(email: email ?? "", code: otp) { result in
                switch result {
                case .success(let isVerified):
                    self.timer?.invalidate()
                    print(isVerified)
                case .failure(let error):
                    print(error)
                    self.otpFields.forEach { input in
                        input.text = ""
                        input.setErrorState()
                    }
                    self.showErrorAlertAction(message: error.localizedDescription)
                }
            }
        }
    }
}

extension VerificationCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)

        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        if string.isEmpty {
            if textField.text?.isEmpty ?? true, textField.tag > 0 {
                otpFields[textField.tag - 1].becomeFirstResponder()
                otpFields[textField.tag - 1].text = ""
            }
            return true
        }

        return textField.text?.isEmpty ?? true
    }
}
