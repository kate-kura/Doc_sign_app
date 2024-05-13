//
//  ProfileViewController1.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit

class ProfileViewController1: UIViewController {
    
    let imagePickerController = UIImagePickerController()
    
    private let navBarLabel = UILabel()
    private let backButton = CustomBackButton()
    let avatarImageView = UIImageView()
    let photoButton = CustomPhotoButton()
    let profileLabel = UILabel()
    let myDataButton = CustomMyDataButton()
    
    let firstName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserFirstName)
    let lastName: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserLastName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        myDataButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        photoButton.addTarget(self, action: #selector(didTapPhotoButton), for: .touchUpInside)

        let (wasLaunchedBefore, isLoggedIn) = Debugger().checkOnLaunch()
        if (isLoggedIn && wasLaunchedBefore) {
            loadImageFromLocal()
        } else {
            UserDefaults.standard.removeObject(forKey: Resources.Keys.keyCurrentUserProfileImage)
            UserDefaults.standard.synchronize()
        }
    }
    
}

extension ProfileViewController1{
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        view.addSubview(avatarImageView)
        view.addSubview(photoButton)
        view.addSubview(profileLabel)
        view.addSubview(myDataButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),

            photoButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -16),
            photoButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -16),
            photoButton.widthAnchor.constraint(equalToConstant: 32),
            photoButton.heightAnchor.constraint(equalToConstant: 32),
            
            profileLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 44),
            profileLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            myDataButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 8),
            myDataButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background

        backButton.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        myDataButton.translatesAutoresizingMaskIntoConstraints = false

        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.profileLabel
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
        
        avatarImageView.image = Resources.Images.avatar
        avatarImageView.tintColor = Resources.Colors.background
        avatarImageView.backgroundColor = Resources.Colors.secondaryLabelColor
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 12
        avatarImageView.clipsToBounds = true
        
        let labelText: String = "\(firstName ?? "") \(lastName ?? "")"
        profileLabel.text = labelText
        profileLabel.textColor = Resources.Colors.primaryLabelColor
        profileLabel.font = Resources.Fonts.helveticaRegular(with: 22)
        profileLabel.textAlignment = .left
        profileLabel.sizeToFit()
        profileLabel.adjustsFontSizeToFitWidth = true

    }

    func saveImageLocally(image: UIImage) {
        autoreleasepool {
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent("profileImage.jpg")
                
                do {
                    try imageData.write(to: fileURL)
                    DefaultsHelper().setString(string: fileURL.lastPathComponent, key: Resources.Keys.keyCurrentUserProfileImage)
                } catch {
                    print("Error saving image: \(error)")
                }
            }
        }
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
    
    @objc private func didTapBack() {
        let vc = ContainerViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        let vc = ProfileViewController2()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapPhotoButton() {
        let ac = UIAlertController(title: "", message: "Выберите изображение", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Камера", style: .default) { [weak self] (_) in
            self?.showImagePicker(selectedSource: .camera)
        }
        let libraryButton = UIAlertAction(title: "Галерея", style: .default) { [weak self] (_) in
            self?.showImagePicker(selectedSource: .photoLibrary)
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .default)
        ac.addAction(cameraButton)
        ac.addAction(libraryButton)
        ac.addAction(cancelButton)
        self.present(ac, animated: true, completion: nil)
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Selected source is not available")
            return
        }
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension ProfileViewController1: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImageView.image = pickedImage
            saveImageLocally(image: pickedImage)
        } else {
            print("Image is not found")
        }
        picker.dismiss(animated: true,completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
