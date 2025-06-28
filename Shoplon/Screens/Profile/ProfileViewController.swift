//
//  ProfileViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit
import FirebaseFirestore

final class ProfileViewController: BaseViewController<ProfileViewModel> {
    private let headerView: HeaderView = {
        let view = HeaderView(icons: [.search])
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
