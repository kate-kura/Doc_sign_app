//
//  ArchiveViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

class ArchiveViewController: UIViewController {
    
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let logoImageView = UIImageView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
    }
}

extension ArchiveViewController {
    
    // MARK: - UI Setup
    func addViews() {
        view.addSubview(primaryLabel)
        view.addSubview(logoImageView)
        view.addSubview(secondaryLabel)
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])

    }

    func configure() {
        view.backgroundColor = Resources.Colors.background
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.archive
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 22)
        primaryLabel.numberOfLines = 1
        primaryLabel.sizeToFit()
        
        logoImageView.image = Resources.Images.logo
        logoImageView.layer.cornerRadius = 16
        logoImageView.clipsToBounds = true

        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.secondaryText5
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 16)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
    }
}
