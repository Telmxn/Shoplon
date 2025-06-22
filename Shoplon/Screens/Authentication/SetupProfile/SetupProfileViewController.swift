//
//  SetupProfileViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 20.06.25.
//

import UIKit
import SnapKit
import PhotosUI
import FirebaseAuth
import Kingfisher
import FirebaseCore

final class SetupProfileViewController: BaseViewController<SetupProfileViewModel>, Keyboardable {
    var targetConstraint: Constraint?
    
    var imageHeight: Int?
    
    var keyboardableImageView: UIImageView?
    
    private let uploadImageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .placeholder
        view.layer.cornerRadius = 60
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var uploadImageButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple100
        view.layer.cornerRadius = 21
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.white.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTakeImageButton))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private let uploadButtonImageView: UIImageView = {
        let view = UIImageView()
        view.image = .camera
        return view
    }()
    
    private lazy var uploadImageLabel: UILabel = {
        let label = UILabel()
        label.text = "uploadImage".localized()
        label.textColor = .purple100
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textAlignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapUploadImageButton))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let formStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillEqually
        return view
    }()
    
    private let fullNameTF: BaseTextField = {
        let textField = BaseTextField(logo: .user, placeholder: "fullName".localized())
        return textField
    }()
    
    private let dateOfBirthTF: BaseTextField = {
        let textField = BaseTextField(logo: .calendar, placeholder: "dateOfBirth".localized())
        return textField
    }()
    
    private let datePicker = UIDatePicker()
    
    private let phoneNumberTF: BasePhoneNumberTextField = {
        let textField = BasePhoneNumberTextField(logo: .phone, placeholder: "phoneNumber".localized())
        textField.withExamplePlaceholder = true
        return textField
    }()
    
    private let buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var skipButton: BaseButton = {
        let button = BaseButton(text: "skip".localized())
        button.layer.borderColor = UIColor.gray20.cgColor
        button.layer.borderWidth = 1.5
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: BaseButton = {
        let button = BaseButton(text: "signUp".localized())
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "setupProfile".localized()
        startKeyboardObserve()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            uploadImageStackView.isHidden = true
            formStackView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(32)
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            }
            uploadImageStackView.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            uploadImageStackView.isHidden = false
            formStackView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(32)
                make.top.equalTo(self.uploadImageStackView.snp.bottom).offset(40)
            }
            uploadImageStackView.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        setupUI()
        setupDatePicker()
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        dateOfBirthTF.inputView = datePicker
        dateOfBirthTF.inputAccessoryView = createToolbar()
    }

    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectDate))
        toolbar.setItems([done], animated: false)
        return toolbar
    }

    @objc func didSelectDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateOfBirthTF.text = formatter.string(from: datePicker.date)
        dateOfBirthTF.resignFirstResponder()
    }
    
    private func setupUI() {
        view.addSubviews(uploadImageStackView, formStackView, buttonsStackView)
        [imageContainerView, uploadImageLabel].forEach(uploadImageStackView.addArrangedSubview)
        imageContainerView.addSubviews(imageView, uploadImageButtonView)
        uploadImageButtonView.addSubview(uploadButtonImageView)
        [fullNameTF, dateOfBirthTF, phoneNumberTF].forEach(formStackView.addArrangedSubview)
        [skipButton, signUpButton].forEach(buttonsStackView.addArrangedSubview)
        
        uploadImageStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(64)
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.size.equalTo(120)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        uploadImageButtonView.snp.makeConstraints { make in
            make.size.equalTo(42)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(-4)
        }
        
        uploadButtonImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.edges.equalToSuperview().inset(9)
        }
        
        formStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(uploadImageStackView.snp.bottom).offset(40)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            targetConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24).constraint
        }
    }
    
    @objc
    private func didTapSkipButton() {
        viewModel.navigateToVerificationCode()
    }
    
    @objc
    private func didTapSignUpButton() {
        viewModel.saveUserData(fullName: fullNameTF.text, dateOfBirth: datePicker.date, image: imageView.image)
    }
    
    @objc
    private func didTapUploadImageButton() {
        openPHPicker()
    }
    
    @objc
    private func didTapTakeImageButton() {
        openCamera()
    }
    
    @objc
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("❌ Camera not available on this device.")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false
        present(picker, animated: true)
    }
}

extension SetupProfileViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                if let error = error {
                    print("Error:", error.localizedDescription)
                    return
                }
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    func openPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        if let image = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                let resizedImage = image.fixedOrientation().resizedToJPEGCompatible()
                self.imageView.image = resizedImage
            }
            print("📷 Image captured:", image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
