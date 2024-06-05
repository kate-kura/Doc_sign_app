//
//  DocFromQRcodeViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 06.05.2024.
//

import UIKit
import PDFKit

class DocFromQRcodeViewController: UIViewController {
    
    let navBarLabel = UILabel()
    let backButton = CustomBackButton()
    
    let companyLabel = UILabel()
    let titleLabel = UILabel()
    let secondaryLabel = UILabel()
    let nextButton = CustomButton()
    
    var pdfView: PDFView!
    let backPDFButton = CustomBackButton()
    let openPDFButton = CustomTextButton()
    
    var textFields: [UITextField] = []
    var textFieldsKeysValues: [String: String] = [:]
    
    // Get data from user defaults
    let QRcodeID: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)
    let companyText: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRdocCompany)
    let titleText: String? = DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRdocTitle)
    let formFields = DefaultsHelper().getStringArray(key: Resources.Keys.keyCurrentFormFields) ?? []
    let backFormFields = DefaultsHelper().getStringArray(key: Resources.Keys.keyCurrentBackendFormFields) ?? []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.layoutViews()
        self.configure()
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        openPDFButton.addTarget(self, action: #selector(openPDFButtonTapped), for: .touchUpInside)
    }
    
}

extension DocFromQRcodeViewController {
    
    // MARK: - UI Setup
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(navBarLabel)
        view.addSubview(companyLabel)
        view.addSubview(titleLabel)
        view.addSubview(openPDFButton)
        view.addSubview(secondaryLabel)
        view.addSubview(nextButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            navBarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            navBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBarLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            companyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            
            titleLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),

            openPDFButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            openPDFButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            openPDFButton.widthAnchor.constraint(equalToConstant: 120),
            
            secondaryLabel.topAnchor.constraint(equalTo: openPDFButton.bottomAnchor, constant: 8),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
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
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        openPDFButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        navBarLabel.textColor = Resources.Colors.secondaryLabelColor
        navBarLabel.text = Resources.Strings.document
        navBarLabel.textAlignment = .center
        navBarLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        navBarLabel.sizeToFit()
        
        companyLabel.text = companyText
        companyLabel.textColor = Resources.Colors.secondaryLabelColor
        companyLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        companyLabel.textAlignment = .left
        companyLabel.numberOfLines = 0
        companyLabel.sizeToFit()
        companyLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.text = titleText
        titleLabel.textColor = Resources.Colors.primaryLabelColor
        titleLabel.font = Resources.Fonts.helveticaRegular(with: 22)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        pdfView = PDFView(frame: view.bounds)
        
        openPDFButton.setTitle(Resources.Strings.openPDF)
        openPDFButton.label.font = Resources.Fonts.helveticaRegular(with: 18)
        openPDFButton.label.textAlignment = .left
        openPDFButton.sizeToFit()
        
        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.fillForm
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 16)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
        
        for (index, field) in formFields.enumerated() {
            let textField = CustomUnderlinedTextField()
            textField.delegate = self
            
            textField.placeholder = field
            textField.keyboardType = .default

            view.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: CGFloat(12 + (index * 50))),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                textField.heightAnchor.constraint(equalToConstant: 32)
            ])

            textFields.append(textField)
        }
        
        nextButton.setTitle(Resources.Strings.toSign)
        nextButton.isEnabled = false
    }
    
    // MARK: - Selectors
    @objc private func didTapBack() {
        let vc = QRcodeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        // Backend communication
        ContractsManager().fillFormFields(respondingPartyKeys: textFieldsKeysValues, completion: { result in
            if result {
                let vc = DocFromQRcodeIsSignedViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                AlertManager.showFetchingBackendError(on: self)
            }
        })
    }
    
    @objc func openPDFButtonTapped() {
        if let pdfURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("contract\(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!).pdf") {
            if let pdfDocument = PDFDocument(url: pdfURL) {
                
                // UI setup
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument

                view.addSubview(pdfView)
                backPDFButton.addTarget(self, action: #selector(closePDFView), for: .touchUpInside)
                view.addSubview(backPDFButton)
                backPDFButton.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backPDFButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                    backPDFButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                ])
            }
        }
    }
    @objc func closePDFView() {
        pdfView.removeFromSuperview()
        backPDFButton.removeFromSuperview()
    }
}

// MARK: - UITextFieldDelegate
extension DocFromQRcodeViewController: UITextFieldDelegate {
    
    // save entered text to textFieldsKeysValues array with backFormFields keys
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let index = textFields.firstIndex(of: textField), let text = textField.text else {return}
        textFieldsKeysValues[backFormFields[index]] = text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.checkTextFields()
        }
        return true
    }
    
    // check if all textFields are filled
    func checkTextFields() {
        let isAnyTextFieldEmpty = textFields.contains { textField in
            return textField.text?.isEmpty ?? true
        }
        nextButton.isEnabled = !isAnyTextFieldEmpty
    }
    
    // hide keyboard with return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
