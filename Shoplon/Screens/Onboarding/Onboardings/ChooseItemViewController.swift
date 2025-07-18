//
//  ChooseItemViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//


import UIKit

class ChooseItemViewController: UIViewController {
    
    private let mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 84
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .chooseItem
        return view
    }()
    
    private let textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "onboarding1title".localized()
        label.font = UIFont.customFont(weight: .medium, size: 32)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "onboarding1subtitle".localized()
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        [imageView, textStackView].forEach(mainStackView.addArrangedSubview)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        
        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(250)
        }
    }
}
