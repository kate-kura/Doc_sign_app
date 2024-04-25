//
//  RegisterController3.swift
//  Doc_sign_app
//
//  Created by Екатерина on 29.01.2024.
//

import UIKit

final class RegisterViewController3: UIViewController {
    
    private let navBarLabel = UILabel()
    private let backButton = CustomBackButton()
    
    private let primaryLabel = UILabel()
    private let nameTextField = CustomTextField()
    private let surnameTextField = CustomTextField()
    private let stackView = UIStackView()
    private let nextButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
}

extension RegisterViewController3{
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        view.addSubview(primaryLabel)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(surnameTextField)
        view.addSubview(stackView)
        
        view.addSubview(nextButton)
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
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            surnameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            surnameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            surnameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            primaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            primaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
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
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.step3
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.registerPrimaryText3
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 28)
        primaryLabel.numberOfLines = 2
        primaryLabel.sizeToFit()
        
        nameTextField.placeholder = Resources.Strings.name
        surnameTextField.placeholder = Resources.Strings.surname
        
        nextButton.setTitle(Resources.Strings.endRegistration)
        nextButton.isEnabled = false
    }
    
    @objc private func didTapBack() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let firstName = self.nameTextField.text else {return}
        guard let lastName = self.surnameTextField.text else {return}
       
        AuthManager().completeSignUp(firstName: firstName, lastName: lastName, completion: { result, statusCode in
            if result {
                DefaultsHelper().setBoolean(boolean: true, key: Resources.Keys.keyCheckIfSignedIn)
                
                let vc = ContainerViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Registration Error", message: "Please, try registration again.", preferredStyle: .alert)
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
}

extension RegisterViewController3: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    func checkTextFields() {
        guard let name = nameTextField.text, let surname = surnameTextField.text else { return }

        let isTextField1FirstResponder = nameTextField.isFirstResponder
        let isTextField2FirstResponder = surnameTextField.isFirstResponder

        if !name.isEmpty && !surname.isEmpty && (isTextField1FirstResponder || isTextField2FirstResponder) {
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
