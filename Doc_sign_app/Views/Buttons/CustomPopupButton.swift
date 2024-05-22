//
//  CustomPopupButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 22.05.2024.
//

import UIKit

 class CustomBottonMenuButtons: UIButton {
    
    let icon = UIImageView()
    let label = UILabel()
    
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

private extension CustomBottonMenuButtons {
    
    func addViews() {
        addSubview(icon)
        addSubview(label)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 8),
            
        ])
    }
    
    func configure() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = Resources.Colors.primaryLabelColor
        icon.contentMode = .scaleAspectFit
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Resources.Colors.primaryLabelColor
        label.font = Resources.Fonts.helveticaRegular(with: 16)
        label.sizeToFit()
    }
}
