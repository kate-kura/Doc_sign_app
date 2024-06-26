//
//  BottomMenuViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 22.05.2024.
//

import UIKit
import PDFKit

class BottomMenuViewController: UIViewController {
    
    var id: Int64?
    var contractTitle: String?
    
    let primaryLabel = UILabel()
    let stackView = UIStackView()
    let watchPDFBotton = CustomBottonMenuButtons()
    let exportPDFBotton = CustomBottonMenuButtons()
    
    var pdfView: PDFView!
    let backPDFButton = CustomBackButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ID переданного элемента: \(String(describing: id))")
        addViews()
        layoutViews()
        configure()
            
        watchPDFBotton.addTarget(self, action: #selector(didTapWatchPDFBotton), for: .touchUpInside)
        exportPDFBotton.addTarget(self, action: #selector(didTapExportPDFBotton), for: .touchUpInside)
    }
}

extension BottomMenuViewController {
    
    // MARK: - UI Setup
    func addViews() {
        view.addSubview(primaryLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(watchPDFBotton)
        stackView.addArrangedSubview(exportPDFBotton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            primaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            primaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            stackView.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 32),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            watchPDFBotton.widthAnchor.constraint(equalToConstant: 120),
            watchPDFBotton.heightAnchor.constraint(equalToConstant: 80),
            
            exportPDFBotton.widthAnchor.constraint(equalToConstant: 120),
            exportPDFBotton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func configure() {
        view.backgroundColor = Resources.Colors.white
        
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        watchPDFBotton.translatesAutoresizingMaskIntoConstraints =  false
        exportPDFBotton.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = contractTitle
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 20)
        primaryLabel.numberOfLines = 1
        primaryLabel.sizeToFit()
        
        stackView.contentMode = .center
        stackView.axis = .horizontal
        stackView.spacing = 64
        
        watchPDFBotton.icon.image = Resources.Images.eye?.withRenderingMode(.alwaysTemplate)
        watchPDFBotton.label.text = Resources.Strings.watch
        exportPDFBotton.icon.image = Resources.Images.share?.withRenderingMode(.alwaysTemplate)
        exportPDFBotton.label.text = Resources.Strings.export
        
        pdfView = PDFView(frame: view.bounds)
    }
    
    // MARK: - Selectors
    @objc func didTapWatchPDFBotton() {
        // Backend communication
        ContractsManager().getPDFContract(id: id!, completion: {result in
            if result {
                if let pdfURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("contract\(String(describing: self.id)).pdf") {
                    if let pdfDocument = PDFDocument(url: pdfURL) {
                        
                        // UI setup
                        self.pdfView.autoScales = true
                        self.pdfView.displayDirection = .vertical
                        self.pdfView.document = pdfDocument

                        self.view.addSubview(self.pdfView)
                        self.backPDFButton.addTarget(self, action: #selector(self.closePDFView), for: .touchUpInside)
                        self.view.addSubview(self.backPDFButton)
                        self.backPDFButton.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            self.backPDFButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
                            self.backPDFButton.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 2),
                        ])
                    }
                }
            } else {
                Logg.err(.error, "Something went wrong during getting PDF Contract.")
                AlertManager.showFetchingBackendError(on: self)
            }
        })
    }
    
    @objc func closePDFView() {
        pdfView.removeFromSuperview()
        backPDFButton.removeFromSuperview()
    }
    
    @objc func didTapExportPDFBotton() {
        let pdfURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("contract\(String(describing: self.id)).pdf")

            if let url = pdfURL {
                do {
                    // Show Activity View Controller and export PDF
                    let data = try Data(contentsOf: url)
                    let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                    present(activityController, animated: true, completion: nil)
                } catch {
                    Logg.err(.error, "Error exporting PDF: \(error)")
                }
            } else {
                Logg.err(.error, "PDF file not found")
            }
    }
}
