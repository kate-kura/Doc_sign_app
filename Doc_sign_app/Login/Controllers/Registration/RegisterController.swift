//
//  RegisterController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 09.01.2024.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let navBarLabel = UILabel()
    private let backButton = CustomBackButton()
    
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomPasswordTextField()
    let showPasswordButton = UIButton(type: .custom)
    private let againPasswordTextField = CustomPasswordTextField()
    let againShowPasswordButton = UIButton(type: .custom)
    private let secondaryLabelPassword = UILabel()
    private let nextButton = CustomButton()
    private let stackView = UIStackView()
    
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

extension RegisterViewController{
    
    private func addViews() {
        
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        view.addSubview(primaryLabel)
        view.addSubview(secondaryLabel)
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(againPasswordTextField)
        stackView.addArrangedSubview(secondaryLabelPassword)
        stackView.addArrangedSubview(nextButton)
        view.addSubview(stackView)
        
        view.addSubview(showPasswordButton)
        view.addSubview(againShowPasswordButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),

            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),

            againPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            againPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            againPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            secondaryLabelPassword.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            secondaryLabelPassword.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: secondaryLabel.topAnchor, constant: -12),
            
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
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabelPassword.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        againPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        againShowPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.step1
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.registerPrimaryText
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 28)
        
        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.secondaryText
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 12)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
        
        emailTextField.placeholder = Resources.Strings.email
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        secondaryLabelPassword.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabelPassword.text = Resources.Strings.secondaryText3
        secondaryLabelPassword.textAlignment = .center
        secondaryLabelPassword.font = Resources.Fonts.helveticaRegular(with: 12)
        secondaryLabelPassword.numberOfLines = 2
        secondaryLabelPassword.sizeToFit()
        
        passwordTextField.placeholder = Resources.Strings.password
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
        againPasswordTextField.placeholder = Resources.Strings.againPassword
        againPasswordTextField.textContentType = .password
        againPasswordTextField.isSecureTextEntry = true
        
        showPasswordButton.tintColor = Resources.Colors.secondaryLabelColor
        showPasswordButton.setImage(Resources.Images.eyeClosed, for: .normal)
        showPasswordButton.setImage(Resources.Images.eye, for: .selected)
        
        againShowPasswordButton.tintColor = Resources.Colors.secondaryLabelColor
        againShowPasswordButton.setImage(Resources.Images.eyeClosed, for: .normal)
        againShowPasswordButton.setImage(Resources.Images.eye, for: .selected)
        
        nextButton.setTitle(Resources.Strings.next)
        nextButton.isEnabled = false
    }
    
    @objc private func didTapBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let email = self.emailTextField.text else {return}
        guard let password = self.againPasswordTextField.text else {return}
        guard let againPassword = self.againPasswordTextField.text else {return}
        
        // Email check
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: againPassword) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthManager().signUp(email: email, password: password, completion: { result in
            if result {
                let vc = RegisterViewController2()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                AlertManager.showRegistrationErrorAlert403(on: self)
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
        
extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    func checkTextFields() {
        guard let mail = emailTextField.text, let password = passwordTextField.text, let againPassword = againPasswordTextField.text else { return }

        if !mail.isEmpty && !password.isEmpty && !againPassword.isEmpty {
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


