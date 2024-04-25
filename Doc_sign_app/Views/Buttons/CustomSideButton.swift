//
//  CustomSideButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.03.2024.
//

import UIKit

final class CustomSideButton: UIButton {
    
    private let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomSideButton {
    
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
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = Resources.Images.equal
        iconView.tintColor = Resources.Colors.secondaryLabelColor
        iconView.contentMode = .scaleAspectFit
    }
}
