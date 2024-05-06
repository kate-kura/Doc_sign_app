//
//  CustomWhiteBackButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 21.04.2024.
//

import UIKit

final class CustomWhiteBackButton: UIButton {
    
    private let icon = UIImageView()
    private let label = UILabel()
    
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
    
    func setTitle(_ title: String) {
        label.text = title
    }
    
    @objc private func buttonTapped() {
        UIView.animate(withDuration: 0.05) {
            self.alpha = 0.8
        }
    }
        
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.05) {
            self.alpha = 1.0
        }
    }
}

private extension CustomWhiteBackButton {
    
    func addViews() {
        addSubview(icon)
        addSubview(label)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            icon.heightAnchor.constraint(equalToConstant: 28),
            icon.widthAnchor.constraint(equalToConstant: 28),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
        ])
    }
    
    func configure() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = Resources.Images.arrowLeft
        icon.tintColor = Resources.Colors.white
        icon.contentMode = .scaleAspectFit
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Resources.Colors.white
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 18)
        label.text = Resources.Strings.back
    }
}

