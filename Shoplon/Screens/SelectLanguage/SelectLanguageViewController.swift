//
//  SelectLanguageViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

class SelectLanguageViewController: BaseViewController {
    
    private let viewModel: SelectLanguageViewModel
    
    private var selectedLanguage: String?
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(text: "next".localized())
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private var textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 8
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(weight: .medium, size: 18)
        label.text = "selectlanguagetitle".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black40
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.text = "selectlanguagesubtitle".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private var languagesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    init(viewModel: SelectLanguageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(textStackView, languagesStackView, nextButton)
        [titleLabel, subtitleLabel].forEach(textStackView.addArrangedSubview)
        
        textStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        let selectedLanguage = DependencyContainer.shared.languageManager.get()
        
        Language.allCases.forEach { language in
            var isSelected = false
            if selectedLanguage == language.rawValue {
                isSelected = true
            }
            
            let languageView: LanguageView = {
                let view = LanguageView(language: language, isSelected: isSelected)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLanguage))
                view.addGestureRecognizer(tapGesture)
                return view
            }()
            
            languagesStackView.addArrangedSubview(languageView)
        }
        
        languagesStackView.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(75)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
    }
    
    @objc
    private func didTapNextButton() {
        viewModel.navigateToLogin()
    }
    
    @objc private func didTapLanguage(_ sender: UITapGestureRecognizer) {
        languagesStackView.arrangedSubviews.forEach { view in
            let language = view as? LanguageView
            language?.setUnselected()
        }
        guard let tappedView = sender.view as? LanguageView else { return }
        selectedLanguage = tappedView.language
        DependencyContainer.shared.languageManager.change(language: selectedLanguage ?? Language.en.rawValue)
        tappedView.setSelected()
        localizeAllTexts()
    }
    
    private func localizeAllTexts() {
        titleLabel.text = "selectlanguagetitle".localized()
        subtitleLabel.text = "selectlanguagesubtitle".localized()
        nextButton.setTitle("next".localized(), for: .normal)
    }
}
