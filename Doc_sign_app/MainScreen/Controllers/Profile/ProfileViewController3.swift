//
//  ProfileViewController3.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

class ProfileViewController3: UIViewController {
    
    private let navBarLabel = UILabel()
    private let backButton = CustomBackButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
}

extension ProfileViewController3 {
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
//        view.addSubview(editDataButton)

    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
//            editDataButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
//            editDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),

        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background

        backButton.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
//        editDataButton.translatesAutoresizingMaskIntoConstraints = false

        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.myDataLabel
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
    
    }
    
    @objc private func didTapBack() {
        let vc = ProfileViewController2()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        let vc = RegisterViewController2()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)

    }
}
