//
//  CustomEditDataButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

final class CustomEditDataButton: UIButton {
    
    private let icon = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        label.text = title
    }
}

private extension CustomEditDataButton {
    
    func addViews() {
        addSubview(label)
        addSubview(icon)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 4),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Resources.Colors.buttonActive
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 18)
        label.text = Resources.Strings.editDataLabel
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = Resources.Images.arrowRight
        icon.tintColor = Resources.Colors.buttonActive
        icon.contentMode = .scaleAspectFit
    }
}
