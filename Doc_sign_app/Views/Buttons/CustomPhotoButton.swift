//
//  CustomPhotoButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

final class CustomPhotoButton: UIButton {
    
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

private extension CustomPhotoButton {
    
    func addViews() {
        addSubview(iconView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func configure() {
        backgroundColor = Resources.Colors.buttonActive
        layer.cornerRadius = 16
        clipsToBounds = true
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = Resources.Images.camera
        iconView.tintColor = Resources.Colors.white
        iconView.contentMode = .scaleAspectFit
    }
}
