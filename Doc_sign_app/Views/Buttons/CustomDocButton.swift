//
//  CustomDocButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.04.2024.
//

import UIKit

final class CustomDocButton: UIButton {
    
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

private extension CustomDocButton {
    
    func addViews() {
        addSubview(icon)
        addSubview(label)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 28),
            icon.widthAnchor.constraint(equalToConstant: 28),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
    
    func configure() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = Resources.Images.doc?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = Resources.Colors.secondaryLabelColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Resources.Colors.primaryLabelColor
        label.font = Resources.Fonts.helveticaRegular(with: 16)
        label.text = Resources.Strings.archive
    }
}

