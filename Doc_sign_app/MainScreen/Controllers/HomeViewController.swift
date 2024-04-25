//
//  HomeViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.03.2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    
    let sideButton = CustomSideButton()
    let searchTextField = CustomTextField()
    let logoImageView = UIImageView()
    let secondaryLabel = UILabel()
    let addButton = CustomAddButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        layoutViews()
        configure()
        
        navigationController?.navigationBar.backgroundColor = Resources.Colors.background
        navigationController?.additionalSafeAreaInsets.top = 12
            
        sideButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapQRCodeButton), for: .touchUpInside)
    }


}

extension HomeViewController {

    func addViews() {
        view.addSubview(sideButton)
        view.addSubview(searchTextField)

        view.addSubview(logoImageView)
        view.addSubview(secondaryLabel)

        view.addSubview(addButton)

    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            
            sideButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sideButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            sideButton.heightAnchor.constraint(equalToConstant: 40),
            sideButton.widthAnchor.constraint(equalToConstant: 36),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: sideButton.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.widthAnchor.constraint(equalToConstant: 312),

            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),

            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])

    }

    func configure() {
        view.backgroundColor = Resources.Colors.background

        sideButton.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        
        searchTextField.placeholder = Resources.Strings.search
        searchTextField.textColor = Resources.Colors.secondaryLabelColor
        
        let textFieldContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 312, height: 40))
        textFieldContainerView.addSubview(searchTextField)
        searchTextField.center = textFieldContainerView.center
        let sideButtonItem = UIBarButtonItem(customView: sideButton)
        let searchTextFieldItem = UIBarButtonItem(customView: textFieldContainerView)
        let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let leftItems = [sideButtonItem, fixedSpaceItem]
        let rightItems = [searchTextFieldItem]

        self.navigationItem.leftBarButtonItems = leftItems
        self.navigationItem.rightBarButtonItems = rightItems

        logoImageView.image = Resources.Images.logo
        logoImageView.layer.cornerRadius = 16
        logoImageView.clipsToBounds = true

        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.secondaryText4
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 16)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()

    }

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc func didTapQRCodeButton() {
        let vc = QRcodeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
