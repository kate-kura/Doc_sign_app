//
//  ForgotPasswordController3.swift
//  Doc_sign_app
//
//  Created by Екатерина on 29.01.2024.
//

import UIKit

final class ForgotPasswordViewController3: UIViewController {
    
    private let backButton = CustomBackButton()
    
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let passwordTextField = CustomPasswordTextField()
    let showPasswordButton = UIButton(type: .custom)
    private let againPasswordTextField = CustomPasswordTextField()
    let againShowPasswordButton = UIButton(type: .custom)
    private let stackView = UIStackView()
    private let nextButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        passwordTextField.delegate = self
        againPasswordTextField.delegate = self
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        againPasswordTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        againShowPasswordButton.addTarget(self, action: #selector(againShowPasswordButtonTapped), for: .touchUpInside)
    }
}

extension ForgotPasswordViewController3{
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(primaryLabel)
        view.addSubview(secondaryLabel)
        
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(againPasswordTextField)
        view.addSubview(stackView)
        
        view.addSubview(nextButton)
        
        view.addSubview(showPasswordButton)
        view.addSubview(againShowPasswordButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            againPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            againPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            againPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: secondaryLabel.topAnchor, constant: -12),
            primaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            primaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            showPasswordButton.widthAnchor.constraint(equalToConstant: 40),
            showPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            showPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            showPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -12),
            
            againShowPasswordButton.widthAnchor.constraint(equalToConstant: 40),
            againShowPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            againShowPasswordButton.centerYAnchor.constraint(equalTo: againPasswordTextField.centerYAnchor),
            againShowPasswordButton.trailingAnchor.constraint(equalTo: againPasswordTextField.trailingAnchor, constant: -12)
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        stackView.axis = .vertical
        stackView.spacing = 12
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        againPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        againShowPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.forgotPasswordPrimaryText3
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 28)
        primaryLabel.numberOfLines = 2
        primaryLabel.sizeToFit()
        
        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.secondaryText3
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 12)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
        
        passwordTextField.placeholder = Resources.Strings.password
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.isSecureTextEntry = true
        
        againPasswordTextField.placeholder = Resources.Strings.againPassword
        againPasswordTextField.textContentType = .oneTimeCode
        againPasswordTextField.isSecureTextEntry = true
        
        showPasswordButton.tintColor = Resources.Colors.secondaryLabelColor
        showPasswordButton.setImage(Resources.Images.eyeClosed, for: .normal)
        showPasswordButton.setImage(Resources.Images.eye, for: .selected)
        
        againShowPasswordButton.tintColor = Resources.Colors.secondaryLabelColor
        againShowPasswordButton.setImage(Resources.Images.eyeClosed, for: .normal)
        againShowPasswordButton.setImage(Resources.Images.eye, for: .selected)
        
        nextButton.setTitle(Resources.Strings.recoverPassword)
        nextButton.isEnabled = false
    }
    
    @objc private func didTapBack() {
        let vc = ForgotPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let password = self.passwordTextField.text else {return}
        guard let repeatPassword = self.againPasswordTextField.text else {return}
        
        // Password check
        if !Validator.isPasswordValid(for: password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        // Password check
        if !Validator.isPasswordValid(for: repeatPassword) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
//        if password != repeatPassword {
//            AlertManager.showPasswordMismatchAlert(on: self)
//            return
//        }
        
        AuthManager().completeChangePassword(password: password, repeatPassword: repeatPassword, completion: { result, statusCode  in
            if result {
                let vc = LogInViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Password Reset Error", message: "Please, try reset password again.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        let vc = LoginORRegisrationViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    @objc func showPasswordButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        showPasswordButton.isSelected = !showPasswordButton.isSelected
    }
    
    @objc func againShowPasswordButtonTapped() {
        againPasswordTextField.isSecureTextEntry = !againPasswordTextField.isSecureTextEntry
        againShowPasswordButton.isSelected = !againShowPasswordButton.isSelected
    }
}

extension ForgotPasswordViewController3: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    func checkTextFields() {
        guard let password = passwordTextField.text, let againPassword = againPasswordTextField.text else { return }

        if !password.isEmpty && !againPassword.isEmpty {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let password = passwordTextField.text, let againPassword = againPasswordTextField.text else {
            return
        }
        
        if password.isEmpty || againPassword.isEmpty {
            return
        }
        
        nextButton.isEnabled = (password == againPassword)
        
        if password != againPassword {
            againPasswordTextField.layer.borderWidth = 1.0
            againPasswordTextField.layer.borderColor = Resources.Colors.redColor.cgColor
        } else {
            againPasswordTextField.layer.borderWidth = 0.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
