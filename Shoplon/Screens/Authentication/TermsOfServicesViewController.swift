//
//  TermsOfServicesViewController.swift
//  Shoplon
//
//  Created by Telman Yusifov on 17.06.25.
//

import UIKit

final class TermsOfServicesViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private var lastDateLabel: UILabel = {
        let label = UILabel()
        let today = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let language = Language(rawValue: DependencyContainer.shared.languageManager.get())?.locale
        formatter.locale = Locale(identifier: language ?? "en_US")
        label.text = "\("lastUpdated".localized()) \(formatter.string(from: today))"
        label.font = UIFont.customFont(weight: .regular, size: 12)
        label.textColor = .black40
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "termsOfService".localized()
        label.textColor = .black
        label.font = UIFont.customFont(weight: .medium, size: 24)
        return label
    }()
    
    private let scrollView = UIScrollView()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .fill
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let buttonItem = UIBarButtonItem(image: .upload, style: .plain, target: self, action: #selector(didTapShareButton))
        navigationItem.rightBarButtonItem = buttonItem
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        setupUI()
        setupSections()
    }
    
    private func setupUI() {
        view.addSubviews(stackView, scrollView)
        scrollView.addSubview(contentStackView)
        [lastDateLabel, titleLabel].forEach(stackView.addArrangedSubview)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(34)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    @objc
    private func didTapShareButton() {
        
    }
    
    private func setupSections() {
        let sections: [(String, String)] = [
            ("1. Terms",
             """
             By accessing this application, you agree to be bound by these Terms of Service, all applicable laws, and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing the app. The materials contained in this application are protected by applicable copyright and trademark law.
             """),

            ("2. Use License",
             """
             Permission is granted to temporarily download one copy of the materials (information or software) on the app for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title. Under this license, you may not:

             - Modify or copy the materials;
             - Use the materials for any commercial purpose or public display;
             - Attempt to decompile or reverse engineer any software contained on the app;
             - Remove any copyright or other proprietary notations from the materials;
             - Transfer the materials to another person or 'mirror' the materials on any other server.

             This license shall automatically terminate if you violate any of these restrictions and may be terminated by the app owner at any time. Upon terminating your viewing of these materials or upon the termination of this license, you must destroy any downloaded materials in your possession.
             """),

            ("3. Disclaimer",
             """
             The materials on this app are provided 'as is'. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.

             Further, we do not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on this app or otherwise relating to such materials or on any sites linked to this app.
             """),

            ("4. Limitations",
             """
             In no event shall the app or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on the app, even if we or an authorized representative has been notified orally or in writing of the possibility of such damage.
             """),

            ("5. Revisions and Errata",
             """
             The materials appearing on the app could include technical, typographical, or photographic errors. We do not warrant that any of the materials on the app are accurate, complete, or current. We may make changes to the materials contained on the app at any time without notice. However, we do not make any commitment to update the materials.
             """),

            ("6. Links",
             """
             We have not reviewed all of the sites linked to this app and are not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by us. Use of any such linked website is at the user's own risk.
             """),

            ("7. Modifications",
             """
             We may revise these Terms of Service at any time without notice. By using this app, you are agreeing to be bound by the then-current version of these Terms of Service. It is your responsibility to review these terms regularly.
             """),

            ("8. Governing Law",
             """
             Any claim relating to the app shall be governed by the laws of the jurisdiction in which the app operator resides, without regard to its conflict of law provisions. You agree to submit to the personal jurisdiction of the courts located within that jurisdiction.
             """)
        ]

            
        for (title, body) in sections {
            contentStackView.addArrangedSubview(makeTitleLabel(title))
            contentStackView.addArrangedSubview(makeBodyLabel(body))
        }
    }
    
    private func makeTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.customFont(weight: .medium, size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
        
    private func makeBodyLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.customFont(weight: .regular, size: 14)
        label.textColor = .black40
        label.numberOfLines = 0
        return label
    }
}
