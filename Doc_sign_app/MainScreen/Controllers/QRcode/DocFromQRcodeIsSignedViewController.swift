//
//  DocFromQRcodeIsSignedViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 06.05.2024.
//

import UIKit

class DocFromQRcodeIsSignedViewController: UIViewController {
    
    let circleView = UIView()
    let iconView = UIImageView()
    let label = UILabel()
    let nextButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
}

extension DocFromQRcodeIsSignedViewController {
    
    private func addViews() {
        view.addSubview(circleView)
        view.addSubview(iconView)
        view.addSubview(label)
        view.addSubview(nextButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20),
            circleView.widthAnchor.constraint(equalToConstant: 56),
            circleView.heightAnchor.constraint(equalToConstant: 56),
            
            iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.background

        circleView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        circleView.backgroundColor = Resources.Colors.greenColor
        circleView.layer.cornerRadius = 28
        circleView.clipsToBounds = true
        
        iconView.image = Resources.Images.check
        iconView.tintColor = Resources.Colors.white
        iconView.contentMode = .scaleAspectFit
        
        label.textColor = Resources.Colors.primaryLabelColor
        label.text = Resources.Strings.documentSigned
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 24)
        label.sizeToFit()
        
        nextButton.setTitle(Resources.Strings.done)
        nextButton.isEnabled = true
    }
    
    @objc private func didTapNext() {
        
        ContractsManager().getContractContent(completion: { result in
            if result {
                let vc = ContainerViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                Logg.err(.error, "Something went wrong during getting Contract Content.")
            }
        })
//        let vc = ContainerViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false, completion: nil)

    }
}
