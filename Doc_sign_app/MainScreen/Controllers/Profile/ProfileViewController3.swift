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
    let name = CustomUnderlinedTextField()
    let surnameHeader = UILabel()
    let surname = CustomUnderlinedTextField()
    let contactsLabel = UILabel()
    let mailHeader = UILabel()
    let mail = CustomUnderlinedTextField()
    let nextButton = CustomButton()
    
    let firstName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserFirstName)
    let lastName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserLastName)
    let email: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        name.delegate = self
        surname.delegate = self
        mail.delegate = self
        
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
        view.addSubview(name)
        view.addSubview(surnameHeader)
        view.addSubview(surname)
        view.addSubview(contactsLabel)
        view.addSubview(mailHeader)
        view.addSubview(mail)
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
            
            name.topAnchor.constraint(equalTo: nameHeader.bottomAnchor, constant: 4),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            name.heightAnchor.constraint(equalToConstant: 32),
            
            surnameHeader.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
            surnameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            surname.topAnchor.constraint(equalTo: surnameHeader.bottomAnchor, constant: 4),
            surname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            surname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            surname.heightAnchor.constraint(equalToConstant: 32),
            
            contactsLabel.topAnchor.constraint(equalTo: surname.bottomAnchor, constant: 24),
            contactsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            mailHeader.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 16),
            mailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            mail.topAnchor.constraint(equalTo: mailHeader.bottomAnchor, constant: 4),
            mail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            mail.heightAnchor.constraint(equalToConstant: 32),
            
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
        name.translatesAutoresizingMaskIntoConstraints = false
        surnameHeader.translatesAutoresizingMaskIntoConstraints = false
        surname.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        mailHeader.translatesAutoresizingMaskIntoConstraints = false
        mail.translatesAutoresizingMaskIntoConstraints = false
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
        
        name.text = firstName
        name.keyboardType = .default
        name.textContentType = .name

        surname.text = lastName
        surname.keyboardType = .default
        surname.textContentType = .name

        mail.text = email
        mail.keyboardType = .default
        mail.textContentType = .name
        
        nextButton.setTitle(Resources.Strings.save)
        nextButton.isEnabled = false
    }
    
    @objc private func didTapBack() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        guard let firstName = self.name.text else {return}
        guard let lastName = self.surname.text else {return}
        guard let email = self.mail.text else {return}
        
        // Name check
        if !Validator.isNameAndSurnameValid(for: firstName) {
            AlertManager.showInvalidNameAlert(on: self)
            return
        }
        
        // Surname check
        if !Validator.isNameAndSurnameValid(for: lastName) {
            AlertManager.showInvalidSurnameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        let vc = ProfileViewController4()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)

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
        guard let name = name.text, let surname = surname.text, let mail = mail.text else { return }

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
