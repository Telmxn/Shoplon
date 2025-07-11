//
//  BaseViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit
import Combine

class BaseViewController<VM: BaseViewModel>: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    let viewModel: VM
    
    private weak var loadingViewController: LoadingViewController? = nil
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackButton()
        bindViewModel()
        let closeKeyboarGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        closeKeyboarGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(closeKeyboarGesture)
        view.backgroundColor = .white
    }
    
    private func setCustomBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @objc
    private func closeKeyboard() {
        view.endEditing(true)
    }
    
    func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.handleLoading(isLoading)
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showErrorAlertAction(message: error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleLoading(_ isLoading: Bool) {
        isLoading ? showLoadingViewController() : dismissLoadingViewController()
    }
    
    private func showLoadingViewController() {
        guard loadingViewController == nil else {return}
        
        closeKeyboard()
        let loadingVC = LoadingViewController()
        
        addChild(loadingVC)
        loadingVC.view.frame = view.bounds
        view.addSubview(loadingVC.view)
        loadingVC.didMove(toParent: self)
        
        loadingViewController = loadingVC
    }
    
    private func dismissLoadingViewController() {
        let loadingVC = loadingViewController
        
        loadingVC?.view.removeFromSuperview()
        loadingVC?.removeFromParent()
        
        loadingViewController = nil
    }
    
    func showErrorAlertAction(message: String) {
        let action = UIAlertController(title: "error".localized(), message: message, preferredStyle: .actionSheet)
        action.addAction(.init(title: "close".localized(), style: .cancel))
        self.present(action, animated: true)
    }
}
