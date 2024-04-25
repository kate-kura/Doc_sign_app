//
//  CustomTextField.swift
//  Doc_sign_app
//
//  Created by Екатерина on 09.01.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CustomTextField {
    
    func configure() {
        backgroundColor = Resources.Colors.white
        textColor = Resources.Colors.secondaryLabelColor
        layer.cornerRadius = 16
        
        layer.masksToBounds = false
        layer.shadowColor = Resources.Colors.secondaryLabelColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.1
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        
        rightViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
    }
}


