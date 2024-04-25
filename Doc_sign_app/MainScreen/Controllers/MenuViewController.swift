//
//  MenuViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.03.2024.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: CaseIterable {
        case profile
        case qrCode
        case archive
    }

    let avatarImageView = UIImageView()
    let profileButton = UIButton()
    let emailLabel = UILabel()
    let qrCodeButtom = CustomQRCodeButton()
    let archiveButton = CustomArchiveButton()
    
    let firstName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserFirstName)
    let lastName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserLastName)
    let email: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail) 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        layoutViews()
        configure()
        
        profileButton.addTarget(self, action: #selector(didSelect(sender:)), for: .touchUpInside)
        qrCodeButtom.addTarget(self, action: #selector(didSelect(sender:)), for: .touchUpInside)
        archiveButton.addTarget(self, action: #selector(didSelect(sender:)), for: .touchUpInside)
        
        let (wasLaunchedBefore, isLoggedIn) = Debugger().checkOnLaunch()
        if (isLoggedIn && wasLaunchedBefore) {
            loadImageFromLocal()
        } else {
            UserDefaults.standard.removeObject(forKey: Resources.Keys.keyCurrentUserProfileImage)
            UserDefaults.standard.synchronize()
        }
    }
    
}

extension MenuViewController {
    func addViews() {
        view.addSubview(avatarImageView)
        view.addSubview(profileButton)
        view.addSubview(emailLabel)
        view.addSubview(qrCodeButtom)
        view.addSubview(archiveButton)

    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            avatarImageView.heightAnchor.constraint(equalToConstant: 64),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            
            profileButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24),
            profileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            profileButton.heightAnchor.constraint(equalToConstant: 32),
            
            emailLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            emailLabel.heightAnchor.constraint(equalToConstant: 32),
        
            qrCodeButtom.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24),
            qrCodeButtom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            qrCodeButtom.heightAnchor.constraint(equalToConstant: 32),

            archiveButton.topAnchor.constraint(equalTo: qrCodeButtom.bottomAnchor, constant: 24),
            archiveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            archiveButton.heightAnchor.constraint(equalToConstant: 32),
        ])

    }

    func configure() {
        view.backgroundColor = Resources.Colors.white

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        qrCodeButtom.translatesAutoresizingMaskIntoConstraints = false
        archiveButton.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.image = Resources.Images.avatar
        avatarImageView.tintColor = Resources.Colors.background
        avatarImageView.backgroundColor = Resources.Colors.secondaryLabelColor
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 12
        avatarImageView.clipsToBounds = true
        
        
        let buttonText: String = "\(firstName ?? "") \(lastName ?? "")"
        profileButton.setTitle(buttonText, for: .normal)
        profileButton.setTitleColor(Resources.Colors.primaryLabelColor, for: .normal)
        profileButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        
        emailLabel.text = email
        emailLabel.textColor = Resources.Colors.secondaryLabelColor
        emailLabel.font = Resources.Fonts.helveticaRegular(with: 16)
        emailLabel.textAlignment = .left
        emailLabel.sizeToFit()
        
        
    }
    
    func loadImageFromLocal() {
        if let filename = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserProfileImage) {
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(filename)
            do {
                let imageData = try Data(contentsOf: fileURL)
                if let image = UIImage(data: imageData) {
                    avatarImageView.image = image
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
    
    @objc func didSelect(sender: UIButton) {
        switch sender {
        case profileButton:
            delegate?.didSelect(menuItem: .profile)
        case qrCodeButtom:
            delegate?.didSelect(menuItem: .qrCode)
        case archiveButton:
            delegate?.didSelect(menuItem: .archive)
        default:
            break
        }
    }
}
