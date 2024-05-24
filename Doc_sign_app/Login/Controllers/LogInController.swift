//
//  LogInController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 09.01.2024.
//

import UIKit

final class LogInViewController: UIViewController {
    
    private let backButton = CustomBackButton()
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let registerButton = CustomTextButton()
    private let label = UILabel()
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomPasswordTextField()
    let showPasswordButton = UIButton(type: .custom)
    private let nextButton = CustomButton()
    private let forgotPasswordButtton = CustomTextButton()
    
    private let stackView = UIStackView()
    private let textStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        forgotPasswordButtton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
    }
    
}

extension LogInViewController{
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(primaryLabel)
        
        textStackView.addArrangedSubview(secondaryLabel)
        textStackView.addArrangedSubview(registerButton)
        view.addSubview(textStackView)
        view.addSubview(label)

        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(nextButton)
        view.addSubview(stackView)
        
        view.addSubview(forgotPasswordButtton)
        view.addSubview(showPasswordButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1000),
            registerButton.widthAnchor.constraint(equalTo: label.widthAnchor),
            textStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textStackView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -4),
            textStackView.widthAnchor.constraint(equalToConstant: 208),
            
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: textStackView.topAnchor, constant: -12),
            
            forgotPasswordButtton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButtton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            forgotPasswordButtton.widthAnchor.constraint(equalToConstant: 100),
            
            showPasswordButton.widthAnchor.constraint(equalToConstant: 40),
            showPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            showPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            showPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -12)
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        stackView.axis = .vertical
        stackView.spacing = 12
        
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.contentMode = .center
        textStackView.axis = .horizontal
        textStackView.distribution = .equalCentering

        backButton.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButtton.translatesAutoresizingMaskIntoConstraints = false
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.enter
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 28)
        
        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.noAccount
        secondaryLabel.textAlignment = .right
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 12)
        secondaryLabel.numberOfLines = 1
        secondaryLabel.sizeToFit()
        
        label.text = Resources.Strings.zaRegister
        label.textColor = Resources.Colors.background
        registerButton.setTitle(Resources.Strings.zaRegister)
        registerButton.sizeToFit()
        
        emailTextField.placeholder = Resources.Strings.email
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        passwordTextField.placeholder = Resources.Strings.password
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
        showPasswordButton.tintColor = Resources.Colors.secondaryLabelColor
        showPasswordButton.setImage(Resources.Images.eyeClosed, for: .normal)
        showPasswordButton.setImage(Resources.Images.eye, for: .selected)
        
        nextButton.setTitle(Resources.Strings.next)
        nextButton.isEnabled = false
        
        forgotPasswordButtton.setTitle(Resources.Strings.forgotPassword)
    }
    
    @objc private func didTapBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let email = self.emailTextField.text else {return}
        guard let password = self.passwordTextField.text else {return}
        
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
        
        AuthManager().signIn(email: email, password: password, completion: { result, statusCode in
            if result {
                DefaultsHelper().setBoolean(boolean: true, key: Resources.Keys.keyCheckIfSignedIn)
                
                ProfileManager().getUserProfileDetails(completion: { result in
                    if result {
                        ContractsManager().getListOfContracts{ (contracts, error) in
                            if let error = error {
                                Logg.err(.error, "")
                            } else {
                                Logg.err(.success, "")
                            }
                            let vc = ContainerViewController()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    } else {
                        Logg.err(.error, "Something went wrong during getting User Profile Details.")
                    }
                })
            } else {
                switch statusCode {
                case 401: AlertManager.showSignInErrorAlert401(on: self)
                case 500: AlertManager.showSignInErrorAlert500(on: self)
                default: AlertManager.defaultAlert(on: self)
                }
            }
        })
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func showPasswordButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        showPasswordButton.isSelected = !showPasswordButton.isSelected
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    func checkTextFields() {
        guard let mail = emailTextField.text, let password = passwordTextField.text else { return }

        if !mail.isEmpty && !password.isEmpty {
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
