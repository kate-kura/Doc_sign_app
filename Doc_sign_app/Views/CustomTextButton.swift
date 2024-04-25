//
//  CustomTextButton.swift
//  Doc_sign_app
//
//  Created by Екатерина on 28.01.2024.
//

import UIKit

final class CustomTextButton: UIButton {
    
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

private extension CustomTextButton {
    
    func addViews() {
        addSubview(label)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
    func configure() {
        sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Resources.Colors.buttonActive
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 12)
        
    }
}
