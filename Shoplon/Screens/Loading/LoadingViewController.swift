//
//  LoadingViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.05.25.
//

import UIKit
import NVActivityIndicatorView

class LoadingViewController: UIViewController {
    
    private let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballScaleMultiple, color: .purple100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black20
        activityIndicator.startAnimating()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
}
