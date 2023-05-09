//
//  GradientSlider.swift
//  Task3 Related Animation
//
//  Created by nastasya on 09.05.2023.
//

import UIKit

final class GradientSlider: UISlider {
    
    let gradientLayer = CAGradientLayer()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clear()
        setupGradientLayer()
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        addTarget(self, action: #selector(upSlider), for: .touchUpInside)
    }
     
    private func clear() {
        value = 0
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        maximumTrackTintColor = .lightGray.withAlphaComponent(0.2)
    }
    
    private func setupGradientLayer() {
        let thumb = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
        gradientLayer.colors = [UIColor.purple.cgColor,
                                UIColor.systemPink.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = .init(x: 0, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 0.5)
        gradientLayer.frame = .init(x: 0, y: 0, width: thumb.midX, height: frame.height)
        gradientLayer.cornerRadius = gradientLayer.frame.height / 2
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func valueChanged() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let thumb = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
        
        gradientLayer.frame = .init(x: 0, y: 0, width: thumb.midX, height: frame.height)
        
        CATransaction.commit()
    }
    
    @objc private func upSlider() {
        let thumb = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
        gradientLayer.frame = .init(x: 0, y: 0, width: thumb.midX, height: frame.height)
    }
}
