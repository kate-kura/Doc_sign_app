//
//  CustomCellButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 21.05.2024.
//

import UIKit

final class CustomCellButton: UIButton {
    
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

private extension CustomCellButton {
    
    func addViews() {
        addSubview(iconView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    func configure() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = Resources.Images.ellipsis
        iconView.tintColor = Resources.Colors.secondaryLabelColor
        iconView.contentMode = .scaleAspectFit
    }
}
