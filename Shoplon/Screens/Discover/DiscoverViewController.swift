//
//  DiscoverViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

final class DiscoverViewController: BaseViewController<DiscoverViewModel> {
    
    private let headerView: HeaderView = {
        let view = HeaderView(icons: [.notification, .message])
        return view
    }()
    
    private let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(headerView, searchTextField)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(headerView.snp.bottom).offset(0)
        }
    }
}
