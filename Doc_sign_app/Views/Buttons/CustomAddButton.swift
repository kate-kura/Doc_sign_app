//
//  CustomAddButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.03.2024.
//

import UIKit

final class CustomAddButton: UIButton {
    
    private let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        layoutViews()
        configure()
        
        addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        UIView.animate(withDuration: 0.05) {
            self.alpha = 0.8
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
        
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.05) {
            self.alpha = 1.0
            self.transform = .identity
        }
    }
}

private extension CustomAddButton {
    
    func addViews() {
        addSubview(iconView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    func configure() {
        backgroundColor = Resources.Colors.buttonActive
        layer.cornerRadius = 28
        clipsToBounds = true
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = Resources.Images.plus
        iconView.tintColor = Resources.Colors.white
        iconView.contentMode = .scaleAspectFit
    }
}
