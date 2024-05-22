//
//  CustomCell.swift
//  Doc_sign_app
//
//  Created by Екатерина on 20.05.2024.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let view = UIView()
    let titleLabel = UILabel()
    let companyLabel = UILabel()
    let actionButton = CustomCellButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
}

extension CustomCell {
    func setupStyle() {
        contentView.backgroundColor = Resources.Colors.background
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.Colors.white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowColor = Resources.Colors.secondaryLabelColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.1
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Resources.Colors.primaryLabelColor
        titleLabel.textAlignment = .left
        titleLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.textColor = Resources.Colors.secondaryLabelColor
        companyLabel.textAlignment = .right
        companyLabel.font = Resources.Fonts.helveticaRegular(with: 12)
        companyLabel.numberOfLines = 0
        companyLabel.sizeToFit()
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(companyLabel)
        view.addSubview(actionButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: companyLabel.leftAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 88),
            
            companyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            companyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            companyLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8),
            companyLabel.widthAnchor.constraint(equalToConstant: 108),
            companyLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 52),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 28),
            actionButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
}
