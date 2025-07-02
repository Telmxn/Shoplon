//
//  TimeContainerView.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.06.25.
//

import UIKit

class TimeContainerView: UIView {
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .medium, size: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init(time: Int) {
        super.init(frame: .zero)
        setupUI()
        setTime(time: time)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white16
        layer.cornerRadius = 8
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.clipsToBounds = true
        addSubview(blurEffectView)
        
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.size.equalTo(41)
        }
    }
    
    func setTime(time: Int) {
        timeLabel.text = String(format: "%02d", time)
    }
}
