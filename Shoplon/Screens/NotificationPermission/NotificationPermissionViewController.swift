//
//  NotificationPermissionViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class NotificationPermissionViewController: BaseViewController<NotificationPermissionViewModel> {
    
    private let topImageView: UIImageView = {
        let view = UIImageView()
        view.image = .notifications
        return view
    }()
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(text: "next".localized())
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private let stackView:UIStackView = {
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
        label.text = "notificationpermissiontitle".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textColor = .black40
        label.text = "notificationpermissionsubtitle".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private let permissionView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray10
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let permissionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    private let permissionLeftStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    private let bellImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        view.image = .bell
        return view
    }()
    
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.text = "notifications".localized()
        return label
    }()
    
    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .purple100
        toggle.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        return toggle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(topImageView, stackView, permissionView, nextButton)
        [titleLabel, subtitleLabel].forEach(stackView.addArrangedSubview)
        permissionView.addSubview(permissionStackView)
        [permissionLeftStackView, toggleSwitch].forEach(permissionStackView.addArrangedSubview)
        [bellImageView, notificationLabel].forEach(permissionLeftStackView.addArrangedSubview)

        topImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(364)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        permissionView.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-48)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        permissionStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
        
        bellImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
    }
    
    @objc
    private func didTapNextButton() {
        viewModel.navigateToLanguageSelector()
    }
    
    @objc
    private func switchToggled() {
        if toggleSwitch.isOn {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
                if let error = error {
                    print("Request Authorization Failed (\(error), \(error.localizedDescription))")
                }
                else{
                    print("Request granted.")
                }
            }
        }
    }
}
