//
//  LoginORregController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 09.01.2024.
//

import UIKit

class LoginORRegisrationViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let logoImageView = UIImageView()
    private let loginButton = CustomButton()
    private let registrationButton = CustomButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
     
        loginButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
}

extension LoginORRegisrationViewController {
    
    // MARK: - UI Setup
    private func addViews() {
        view.addSubview(logoImageView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registrationButton)
        view.addSubview(stackView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
            registrationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            registrationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            registrationButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 20
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Resources.Images.logo
        logoImageView.layer.cornerRadius = 16
        logoImageView.clipsToBounds = true
        
        loginButton.setTitle(Resources.Strings.enter)
        registrationButton.setTitle(Resources.Strings.registerPrimaryText)
    }
    

    // MARK: - Selectors
    @objc private func didTapLogIn() {
        let vc = LogInViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
