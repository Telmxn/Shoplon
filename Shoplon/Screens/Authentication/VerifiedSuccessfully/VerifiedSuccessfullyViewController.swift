//
//  VerifiedSuccessfullyViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit

final class VerifiedSuccessfullyViewController: BaseViewController<VerifiedSuccessfullyViewModel> {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 64
        view.alignment = .center
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .successfullVerification
        return view
    }()
    
    private let textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        view.alignment = .center
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(weight: .medium, size: 24)
        label.textAlignment = .center
        label.text = "whoohooo".localized()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black40
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "emailVerifiedSuccessfully".localized()
        return label
    }()
    
    private lazy var goToShoppingButton: BaseButton = {
        let button = BaseButton(text: "goToShopping".localized())
        button.addTarget(self, action: #selector(didTapGoToShoppingButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(stackView, goToShoppingButton)
        [imageView, textStackView].forEach(stackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(250)
        }
        
        goToShoppingButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
    }
    
    @objc
    private func didTapGoToShoppingButton() {
        self.viewModel.navigateToSetPrivacy()
    }
}
