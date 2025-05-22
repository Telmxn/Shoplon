//
//  OnboardingViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 21.05.25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    private var viewModel: OnboardingViewModel
    
    private var currentViewControllerIndex = 0
    
    private let firstOnboarding = ChooseItemViewController()
    private let secondOnboarding = AddToCardViewController()
    private let thirdOnboarding = PayOnlineViewController()
    private let fourthOnboarding = TrackOrderViewController()
    private let fifthOnboarding = FindStoreViewController()
    
    private lazy var viewControllers: [UIViewController] = [
        firstOnboarding,
        secondOnboarding,
        thirdOnboarding,
        fourthOnboarding,
        fifthOnboarding
    ]
    
    private lazy var pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageController.setViewControllers([firstOnboarding], direction: .forward, animated: true)
        pageController.dataSource = self
        pageController.delegate = self
        return pageController
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("skip".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.customFont(weight: .medium, size: 14)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    private var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.layer.cornerRadius = 31
        button.backgroundColor = .purple100
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private var progressStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 5
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pageController.view)
        addChild(pageController)
        pageController.didMove(toParent: self)
        pageController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        for _ in viewControllers {
            let subProgressView: UIView = {
                let view = UIView()
                view.backgroundColor = .purple100
                view.layer.cornerRadius = 2
                view.layer.opacity = 0.3
                return view
            }()
            
            subProgressView.snp.makeConstraints { make in
                make.size.equalTo(4)
            }
            
            progressStackView.addArrangedSubview(subProgressView)
        }
        
        progressStackView.arrangedSubviews[currentViewControllerIndex].layer.opacity = 1
        progressStackView.arrangedSubviews[currentViewControllerIndex].snp.updateConstraints { make in
            make.height.equalTo(12)
        }
        view.layoutIfNeeded()
        
        setupUI()
    }
    
    @objc
    private func didTapNextButton() {
        if currentViewControllerIndex < (viewControllers.count - 1) {
            currentViewControllerIndex += 1
            pageController.setViewControllers([viewControllers[currentViewControllerIndex]], direction: .forward, animated: true)
            updateProgressView()
        } else {
            viewModel.navigateToNotificationPermission()
        }
    }
    
    @objc
    private func didTapSkipButton() {
        viewModel.navigateToNotificationPermission()
    }
    
    private func getViewController(by index: Int) -> UIViewController? {
        if index == 0 {
            return firstOnboarding
        } else if index == 1 {
            return secondOnboarding
        } else if index == 2 {
            return thirdOnboarding
        } else if index == 3 {
            return fourthOnboarding
        } else if index == 4 {
            return fifthOnboarding
        }
        return nil
    }
    
    private func setupUI() {
        view.addSubviews(bottomStackView, skipButton)
        [progressStackView, nextButton].forEach(bottomStackView.addArrangedSubview)
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        nextButton.snp.makeConstraints { make in
            make.size.equalTo(62)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(32)
        }
    }
    
    private func updateProgressView() {
        progressStackView.arrangedSubviews.forEach { progressView in
            UIView.animate(withDuration: 0.4) {
                progressView.layer.opacity = 0.3
                progressView.snp.updateConstraints { make in
                    make.height.equalTo(4)
                }
                self.view.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: 0.4) {
            self.progressStackView.arrangedSubviews[self.currentViewControllerIndex].layer.opacity = 1
            self.progressStackView.arrangedSubviews[self.currentViewControllerIndex].snp.updateConstraints { make in
                make.height.equalTo(12)
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let newIndex = currentViewControllerIndex - 1
        return getViewController(by: newIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let newIndex = currentViewControllerIndex + 1
        return getViewController(by: newIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let viewController = pageViewController.viewControllers?.first else {
            return
        }
        if let index = viewControllers.firstIndex(of: viewController) {
            currentViewControllerIndex = index
            updateProgressView()
        }
    }
}
