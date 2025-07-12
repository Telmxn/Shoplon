//
//  SearchView.swift
//  Shoplon
//
//  Created by Telman Yusifov on 24.06.25.
//

import UIKit

protocol SearchViewDelegate {
    func didTapFilter()
}

class SearchView: UIView {
    
    let searchTF: SearchTextField = {
        let tf = SearchTextField()
        return tf
    }()
    
    private let rightStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    private lazy var filterImageView: UIImageView = {
        let view = UIImageView()
        view.image = .filter
        view.tintColor = .black
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFilterButton))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private var delegate: SearchViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        addSubviews(searchTF, rightStackView)
        [lineView, filterImageView].forEach(rightStackView.addArrangedSubview)
        
        searchTF.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(1.5)
            make.verticalEdges.equalToSuperview()
        }
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(16)
        }
        
        filterImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    func subscribe(_ delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    @objc
    func didTapFilterButton() {
        delegate?.didTapFilter()
    }
}
