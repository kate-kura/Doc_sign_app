//
//  ArchiveViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

class ArchiveViewController: UIViewController {
    
    let primaryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
    }
}

extension ArchiveViewController {
    func addViews() {
        view.addSubview(primaryLabel)

    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

    }

    func configure() {
        view.backgroundColor = Resources.Colors.background
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.archive
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 22)
        primaryLabel.numberOfLines = 1
        primaryLabel.sizeToFit()
    }
}
