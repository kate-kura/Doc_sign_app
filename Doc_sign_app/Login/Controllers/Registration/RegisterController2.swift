//
//  RegisterController2.swift
//  Doc_sign_app
//
//  Created by Екатерина on 29.01.2024.
//

import UIKit

final class RegisterViewController2: UIViewController {
    
    private let navBarLabel = UILabel()
    private let backButton = CustomBackButton()
    
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let codeTextField = CustomTextField()
    private let nextButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        codeTextField.delegate = self
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
}

extension RegisterViewController2{
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        view.addSubview(primaryLabel)
        view.addSubview(secondaryLabel)
        view.addSubview(codeTextField)
        view.addSubview(nextButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            codeTextField.widthAnchor.constraint(equalToConstant: 160),
            codeTextField.heightAnchor.constraint(equalToConstant: 44),
            
            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: codeTextField.topAnchor, constant: -8),
            secondaryLabel.widthAnchor.constraint(equalToConstant: 184),
            
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: secondaryLabel.topAnchor, constant: -12),
            primaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            primaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            nextButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 160),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.step2
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.registerPrimaryText2
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 28)
        primaryLabel.numberOfLines = 2
        primaryLabel.sizeToFit()
        
        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.secondaryText2
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 12)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
        
        codeTextField.placeholder = Resources.Strings.code
        
        nextButton.setTitle(Resources.Strings.confirm)
        nextButton.isEnabled = false
        
    }
    
    @objc private func didTapBack() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let code = self.codeTextField.text else {return}
        
        AuthManager().confirmSignUp(code: code, completion: { result in
            if result {
                let vc = RegisterViewController3()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                AlertManager.showVerifyCodeErrorAlert400(on: self)
                Logg.err(.error, "Something went wrong after confirming account.")
            }
        })
        
    }
}

extension RegisterViewController2: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    func checkTextFields() {
        guard let code = codeTextField.text else { return }

        if !code.isEmpty {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
