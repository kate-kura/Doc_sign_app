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
    
    let basicLabel = UILabel()
    let nameHeader = UILabel()
    let nameTextField = CustomUnderlinedTextField()
    let surnameHeader = UILabel()
    let surnameTextField = CustomUnderlinedTextField()
    let contactsLabel = UILabel()
    let mailHeader = UILabel()
    let mailTextField = CustomUnderlinedTextField()
    let nextButton = CustomButton()
    
    let firstName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserFirstName)
    let lastName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserLastName)
    let email: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        mailTextField.delegate = self
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
}

extension ProfileViewController3 {
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        
        view.addSubview(basicLabel)
        view.addSubview(nameHeader)
        view.addSubview(nameTextField)
        view.addSubview(surnameHeader)
        view.addSubview(surnameTextField)
        view.addSubview(contactsLabel)
        view.addSubview(mailHeader)
        view.addSubview(mailTextField)
        view.addSubview(nextButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            basicLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            basicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            nameHeader.topAnchor.constraint(equalTo: basicLabel.bottomAnchor, constant: 16),
            nameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            nameTextField.topAnchor.constraint(equalTo: nameHeader.bottomAnchor, constant: 4),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nameTextField.heightAnchor.constraint(equalToConstant: 32),
            
            surnameHeader.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            surnameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            surnameTextField.topAnchor.constraint(equalTo: surnameHeader.bottomAnchor, constant: 4),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            surnameTextField.heightAnchor.constraint(equalToConstant: 32),
            
            contactsLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 24),
            contactsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            mailHeader.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 16),
            mailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            mailTextField.topAnchor.constraint(equalTo: mailHeader.bottomAnchor, constant: 4),
            mailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            mailTextField.heightAnchor.constraint(equalToConstant: 32),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background

        backButton.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        basicLabel.translatesAutoresizingMaskIntoConstraints = false
        nameHeader.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameHeader.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        mailHeader.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.myDataLabel
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
        
        basicLabel.textColor = Resources.Colors.secondaryLabelColor
        basicLabel.text = Resources.Strings.basic
        basicLabel.textAlignment = .left
        basicLabel.font = Resources.Fonts.helveticaRegular(with: 24)
        basicLabel.sizeToFit()
        
        contactsLabel.textColor = Resources.Colors.secondaryLabelColor
        contactsLabel.text = Resources.Strings.contacts
        contactsLabel.textAlignment = .left
        contactsLabel.font = Resources.Fonts.helveticaRegular(with: 24)
        contactsLabel.sizeToFit()
        
        nameHeader.textColor = Resources.Colors.secondaryLabelColor
        nameHeader.text = Resources.Strings.name
        nameHeader.textAlignment = .left
        nameHeader.font = Resources.Fonts.helveticaRegular(with: 14)
        nameHeader.sizeToFit()
        
        surnameHeader.textColor = Resources.Colors.secondaryLabelColor
        surnameHeader.text = Resources.Strings.surname
        surnameHeader.textAlignment = .left
        surnameHeader.font = Resources.Fonts.helveticaRegular(with: 14)
        surnameHeader.sizeToFit()
        
        mailHeader.textColor = Resources.Colors.secondaryLabelColor
        mailHeader.text = Resources.Strings.mail
        mailHeader.textAlignment = .left
        mailHeader.font = Resources.Fonts.helveticaRegular(with: 14)
        mailHeader.sizeToFit()
        
        nameTextField.text = firstName
        nameTextField.keyboardType = .default
        nameTextField.textContentType = .name
        nameTextField.autocapitalizationType = .words

        surnameTextField.text = lastName
        surnameTextField.keyboardType = .default
        surnameTextField.textContentType = .name
        surnameTextField.autocapitalizationType = .words
        
        mailTextField.text = email
        mailTextField.keyboardType = .emailAddress
        mailTextField.textContentType = .emailAddress
//        mailTextField.isEnabled = false
        
        nextButton.setTitle(Resources.Strings.save)
        nextButton.isEnabled = false
    }
    
    @objc private func didTapBack() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let name = self.nameTextField.text else {return}
        guard let surname = self.surnameTextField.text else {return}
        guard let email = self.mailTextField.text else {return}
        
        // Name check
        if !Validator.isNameValid(for: name) {
            AlertManager.showInvalidNameAlert(on: self)
            return
        }
        
        // Surname check
        if !Validator.isSurnameValid(for: surname) {
            AlertManager.showInvalidSurnameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        ProfileManager().updateUserProfileDetails(firstName: name, lastName: surname, email: email, completion: { result in
            if result {
                let vc = ContainerViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                Logg.err(.error, "Something went wrong during updating User Profile Details.")
            }
        })
        
//        let vc = ProfileViewController4()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false, completion: nil)

    }
}

extension ProfileViewController3: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    func checkTextFields() {
        guard let name = nameTextField.text, let surname = surnameTextField.text, let mail = mailTextField.text else { return }

        if name != firstName || surname != lastName || mail != email {
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
