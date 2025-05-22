//
//  NotificationPermissionViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

class NotificationPermissionViewController: BaseViewController {
    
    private let viewModel: NotificationPermissionViewModel
    
    init(viewModel: NotificationPermissionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
