//
//  SelectLanguageViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

class SelectLanguageViewController: BaseViewController {
    
    private let viewModel: SelectLanguageViewModel
    
    private lazy var nextButton: BaseButton = {
        let button = BaseButton(text: "next".localized())
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
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
        view.addSubviews(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
    }
    
    @objc
    private func didTapNextButton() {
        viewModel.navigateToLogin()
    }
}
