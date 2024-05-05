//
//  CustomUnderlinedTextField.swift
//  Doc_sign_app
//
//  Created by Екатерина on 05.05.2024.
//

import UIKit

final class CustomUnderlinedTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let underline = self.layer.sublayers?.first(where: { $0.frame.height == 1 }) {
            underline.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        }
    }
}

private extension CustomUnderlinedTextField {
    
    func configure() {
        
        backgroundColor = .clear
        textColor = Resources.Colors.secondaryLabelColor
        font = Resources.Fonts.helveticaRegular(with: 18)
        
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        underline.backgroundColor = Resources.Colors.secondaryLabelColor.cgColor
                
        self.borderStyle = .none
        self.layer.addSublayer(underline)
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
    }
}
