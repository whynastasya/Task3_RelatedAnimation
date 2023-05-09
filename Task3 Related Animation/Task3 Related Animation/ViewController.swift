//
//  ViewController.swift
//  Task3 Related Animation
//
//  Created by nastasya on 07.05.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let squareView = UIView()
    private let squareViewDimension = CGFloat(100)
    private let slider = UISlider()
    private var animator = UIViewPropertyAnimator()
    private var constraints = [NSLayoutConstraint]()
    private var squareViewLeadingConstraint: NSLayoutConstraint? = nil
    private var squareViewTrailingConstraint: NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squareView)
        view.addSubview(slider)
        
        setupSlider()
        setupConstraints()
        setupGradientLayer()
        
        animator = UIViewPropertyAnimator(duration: 0.6, curve: .easeInOut, animations: {
            self.squareView.transform = CGAffineTransform(rotationAngle: .pi/2)
            self.squareView.transform = self.squareView.transform.scaledBy(x: 1.5, y: 1.5)
            
            self.squareViewLeadingConstraint?.isActive = false
            self.squareViewTrailingConstraint?.isActive = true
            
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func changeValue(_ sender: UISlider) {
        animator.pausesOnCompletion = true
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func upSlider(_ sender: UISlider) {
        sender.setValue(sender.maximumValue, animated: true)
        animator.continueAnimation(withTimingParameters: .none, durationFactor: 0)
    }
    
    private func setupSlider() {
        slider.tintColor = .systemPink.withAlphaComponent(0.4)
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        slider.addTarget(self, action: #selector(upSlider), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        squareView.translatesAutoresizingMaskIntoConstraints = false
        
        squareViewTrailingConstraint = squareView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -1.5 * squareViewDimension / 6)
        squareViewLeadingConstraint = squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        squareViewLeadingConstraint?.isActive = true
        
        constraints.append(squareView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100))
        constraints.append(squareView.widthAnchor.constraint(equalToConstant: squareViewDimension))
        constraints.append(squareView.heightAnchor.constraint(equalToConstant: squareViewDimension))
        
        constraints.append(slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor))
        constraints.append(slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor))
        constraints.append(slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: squareViewDimension / 3))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: squareViewDimension, height: squareViewDimension)
        gradientLayer.colors = [
            UIColor.purple.cgColor,
            UIColor.systemPink.withAlphaComponent(0.3).cgColor
        ]
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPointMake(0.4, 0)
        gradientLayer.endPoint = CGPointMake(0.3, 1)
        gradientLayer.cornerRadius = 20
        squareView.layer.addSublayer(gradientLayer)
    }
}

