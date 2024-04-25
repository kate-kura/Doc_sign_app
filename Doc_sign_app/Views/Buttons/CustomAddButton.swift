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
        
//        self.layer.cornerRadius = frame.width / 2
//        self.clipsToBounds = true
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
