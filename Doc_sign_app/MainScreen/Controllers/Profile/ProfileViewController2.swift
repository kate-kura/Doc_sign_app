//
//  ProfileViewController2.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

class ProfileViewController2: UIViewController {
    
    private let navBarLabel = UILabel()
    private let backButton = CustomBackButton()
    
    let editDataButton = CustomEditDataButton()
    let basicLabel = UILabel()
    let nameHeader = UILabel()
    let name = UILabel()
    let surnameHeader = UILabel()
    let surname = UILabel()
    let contactsLabel = UILabel()
    let mailHeader = UILabel()
    let mail = UILabel()
    
    let exitButton = UIButton()
    
    let firstName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserFirstName)
    let lastName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserLastName)
    let email: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        editDataButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
    }
    
}

extension ProfileViewController2{
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        view.addSubview(editDataButton)
        view.addSubview(basicLabel)
        view.addSubview(nameHeader)
        view.addSubview(name)
        view.addSubview(surnameHeader)
        view.addSubview(surname)
        view.addSubview(contactsLabel)
        view.addSubview(mailHeader)
        view.addSubview(mail)
        view.addSubview(exitButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            editDataButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 24),
            editDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            basicLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 80),
            basicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            nameHeader.topAnchor.constraint(equalTo: basicLabel.bottomAnchor, constant: 16),
            nameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            name.topAnchor.constraint(equalTo: nameHeader.bottomAnchor, constant: 4),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            surnameHeader.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
            surnameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            surname.topAnchor.constraint(equalTo: surnameHeader.bottomAnchor, constant: 4),
            surname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            surname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            contactsLabel.topAnchor.constraint(equalTo: surname.bottomAnchor, constant: 24),
            contactsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            mailHeader.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 16),
            mailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            mail.topAnchor.constraint(equalTo: mailHeader.bottomAnchor, constant: 4),
            mail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background

        backButton.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        editDataButton.translatesAutoresizingMaskIntoConstraints = false
        basicLabel.translatesAutoresizingMaskIntoConstraints = false
        nameHeader.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        surnameHeader.translatesAutoresizingMaskIntoConstraints = false
        surname.translatesAutoresizingMaskIntoConstraints = false
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        mailHeader.translatesAutoresizingMaskIntoConstraints = false
        mail.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        name.textColor = Resources.Colors.primaryLabelColor
        name.text = firstName
        name.textAlignment = .left
        name.font = Resources.Fonts.helveticaRegular(with: 18)
        name.sizeToFit()
        
        surname.textColor = Resources.Colors.primaryLabelColor
        surname.text = lastName
        surname.textAlignment = .left
        surname.font = Resources.Fonts.helveticaRegular(with: 18)
        surname.sizeToFit()
        
        mail.textColor = Resources.Colors.primaryLabelColor
        mail.text = email
        mail.textAlignment = .left
        mail.font = Resources.Fonts.helveticaRegular(with: 18)
        mail.sizeToFit()
        
        exitButton.setTitle(Resources.Strings.exitButton, for: .normal)
        exitButton.titleLabel?.font = Resources.Fonts.helveticaRegular(with: 18)
        exitButton.setTitleColor(Resources.Colors.redColor, for: .normal)
    
    }
    
    @objc private func didTapBack() {
        let vc = ProfileViewController1()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        let vc = ProfileViewController3()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)

    }
    
    @objc private func didTapLogOut() {
        
        DefaultsHelper().removePersistentDomain()
        DefaultsHelper().setBoolean(boolean: true, key: Resources.Keys.keyCheckFirstLaunch)
        
        let vc = LoginORRegisrationViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
}
