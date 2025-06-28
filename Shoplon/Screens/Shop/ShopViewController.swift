//
//  ShopViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 23.06.25.
//

import UIKit

final class ShopViewController: BaseViewController<ShopViewModel> {
    private let headerView: HeaderView = {
        let view = HeaderView(icons: [.notification, .message])
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
    }
}
