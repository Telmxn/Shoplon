//
//  SaleCollectionViewCell.swift
//  Shoplon
//
//  Created by Telman Yusifov on 29.06.25.
//

import UIKit

final class SaleCollectionViewCell: BaseCollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .sale
        return view
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.grandisFont(weight: .medium, size: 24)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Super Flash Sale 50% Off"
        label.textAlignment = .center
        return label
    }()
    
    private let timerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    private let hourView: TimeContainerView = {
        let view = TimeContainerView(time: 10)
        return view
    }()
    
    private let colonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .bold, size: 14)
        label.textColor = .white
        label.text = ":"
        label.textAlignment = .center
        return label
    }()
    
    private let minutesView: TimeContainerView = {
        let view = TimeContainerView(time: 10)
        return view
    }()
    
    private let secondColonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(weight: .bold, size: 14)
        label.textColor = .white
        label.text = ":"
        label.textAlignment = .center
        return label
    }()
    
    private let secondsView: TimeContainerView = {
        let view = TimeContainerView(time: 10)
        return view
    }()
    
    private var timer: Timer? = nil
    private var timeLeftSeconds: Int = 10000
    
    override func setupUI() {
        super.setupUI()
        
        scheduleTimeLeft()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.scheduleTimeLeft()
        })
        
        contentView.addSubviews(imageView, overlayView, stackView)
        [titleLabel, timerStackView].forEach(stackView.addArrangedSubview)
        [
            hourView,
            colonLabel,
            minutesView,
            secondColonLabel,
            secondsView
        ].forEach(timerStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(60)
            make.verticalEdges.equalToSuperview().inset(40)
        }
    }
    
    private func scheduleTimeLeft() {
        self.timeLeftSeconds -= 1
        let leftHours = self.timeLeftSeconds/60/60
        let leftMinutes = self.timeLeftSeconds%3600/60
        let leftSeconds = self.timeLeftSeconds%60
        
        hourView.setTime(time: leftHours)
        minutesView.setTime(time: leftMinutes)
        secondsView.setTime(time: leftSeconds)
        
        if self.timeLeftSeconds == 0 {
            self.timer?.invalidate()
        }
    }
}
