//
//  BottomMenuViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 22.05.2024.
//

import UIKit

class BottomMenuViewController: UIViewController {
    
    let stackView = UIStackView()
    let watchPDFBotton = CustomBottonMenuButtons()
    let exportPDFBotton = CustomBottonMenuButtons()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        layoutViews()
        configure()
            
        watchPDFBotton.addTarget(self, action: #selector(didTapWatchPDFBotton), for: .touchUpInside)
        exportPDFBotton.addTarget(self, action: #selector(didTapExportPDFBotton), for: .touchUpInside)
    }
}

extension BottomMenuViewController {
    func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(watchPDFBotton)
        stackView.addArrangedSubview(exportPDFBotton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            watchPDFBotton.widthAnchor.constraint(equalToConstant: 120),
            watchPDFBotton.heightAnchor.constraint(equalToConstant: 80),
            
            exportPDFBotton.widthAnchor.constraint(equalToConstant: 120),
            exportPDFBotton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func configure() {
        view.backgroundColor = Resources.Colors.white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        watchPDFBotton.translatesAutoresizingMaskIntoConstraints =  false
        exportPDFBotton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.contentMode = .center
        stackView.axis = .horizontal
        stackView.spacing = 64
        
        watchPDFBotton.icon.image = Resources.Images.eye?.withRenderingMode(.alwaysTemplate)
        watchPDFBotton.label.text = Resources.Strings.watch
        exportPDFBotton.icon.image = Resources.Images.share?.withRenderingMode(.alwaysTemplate)
        exportPDFBotton.label.text = Resources.Strings.export
    }
    
    @objc func didTapWatchPDFBotton() {
        print("didTap Watch PDFBotton")
    }
    
    @objc func didTapExportPDFBotton() {
        print("didTap Export PDFBotton")
    }
}
