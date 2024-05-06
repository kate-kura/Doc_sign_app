//
//  CustomBackgroundView.swift
//  Doc_sign_app
//
//  Created by Екатерина on 06.05.2024.
//

import UIKit

class CustomBackgroundView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let windowSideLength = self.bounds.width - 96
        let windowRect = CGRect(x: 48, y: (self.bounds.height - windowSideLength - 100) / 2, width: windowSideLength, height: windowSideLength)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 0)
        let windowPath = UIBezierPath(roundedRect: windowRect, cornerRadius: 10)
        path.append(windowPath)
        path.usesEvenOddFillRule = true
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        layer.mask = maskLayer

    }
}


