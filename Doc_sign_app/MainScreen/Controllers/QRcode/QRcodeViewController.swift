//
//  QRcodeViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit
import AVFoundation

class QRcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let backgroundView = CustomBackgroundView()
    let backButton = CustomWhiteBackButton()
    let massageLabel = UILabel()
    let nextButton = CustomButton()
    
    var captureSession = AVCaptureSession()
    var vedioPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
        
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        // Get camera device
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            Logg.err(.error, "Failed to get the camera device")
            AlertManager.showCameraError(on: self)
            return
        }
        
        // Capture session setup
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetaDataOutput)
            
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Vedio preview setup
            vedioPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            vedioPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            vedioPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(vedioPreviewLayer!)
            
            // Start capture session
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
            
            // view setup
            view.bringSubviewToFront(backgroundView)
            view.bringSubviewToFront(backButton)
            view.bringSubviewToFront(massageLabel)
            view.bringSubviewToFront(nextButton)
            
            qrCodeFrameView = UIView()
            if let qrcodeFrameView = qrCodeFrameView {
                qrcodeFrameView.layer.borderColor = Resources.Colors.redColor.cgColor
                qrcodeFrameView.layer.borderWidth = 2
                view.addSubview(qrcodeFrameView)
                view.bringSubviewToFront(qrcodeFrameView)
            }
        } catch {
            print(error)
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
}

extension QRcodeViewController {
    
    // MARK: - UI Setup
    func addViews() {
        view.addSubview(backgroundView)
        view.addSubview(backButton)
        view.addSubview(massageLabel)
        view.addSubview(nextButton)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            massageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            massageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -280),
            massageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            massageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            massageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 160),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.topAnchor.constraint(equalTo: massageLabel.bottomAnchor, constant: 16),
        ])
    }
    
    func configure() {        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        massageLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        backgroundView.backgroundColor = Resources.Colors.secondaryLabelColor
        backgroundView.alpha = 0.7

        massageLabel.text = Resources.Strings.qrText
        massageLabel.textColor = Resources.Colors.white
        massageLabel.textAlignment = .center
        massageLabel.font = Resources.Fonts.helveticaRegular(with: 14)
        massageLabel.numberOfLines = 0
        massageLabel.lineBreakMode = .byWordWrapping
        
        nextButton.setTitle(Resources.Strings.openDocument)
        nextButton.isHidden = true
    }
    
    // Processing of QR-code scanning results
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Setup view when QR-code is NOT detected
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            massageLabel.text = Resources.Strings.qrText
            nextButton.isHidden = true
            return
        }
        
        // Retrieve the first detected metadata object
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Check if metadata object is QR-code
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let qrCodeObject = vedioPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = qrCodeObject!.bounds
            
            // Show nextButton if QR-code is successfully scanned
            if metadataObj.stringValue != nil {
                nextButton.isHidden = false
            }
            
            // Save QR-code ID in UserDefaults
            if let qrCodeString = metadataObj.stringValue {
                let components = qrCodeString.components(separatedBy: "/")
                DefaultsHelper().setString(string: components.last ?? "", key: Resources.Keys.keyCurrentQRcodeID)
            }
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapBack() {
        let vc = ContainerViewController()
        captureSession.stopRunning()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        
        // Backend communication
        ContractsManager().getFormContentFromQR(completion: { result in
            if result {
                ContractsManager().getPDFForm(completion: {result in
                    if result {
                        let vc = DocFromQRcodeViewController()
                        self.captureSession.stopRunning()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                    } else {
                        Logg.err(.error, "Something went wrong during getting PDF Form.")
                        AlertManager.showFetchingQRcodeError(on: self)
                    }
                })
            } else {
                Logg.err(.error, "Something went wrong during getting Form Content.")
                AlertManager.showFetchingQRcodeError(on: self)
            }
        })
        
        // Backend communication
        ContractsManager().getFormFields(completion: { result in
            if result {} else {
                Logg.err(.error, "Something went wrong during getting Form Fields.")
                AlertManager.showFetchingQRcodeError(on: self)
            }
        })
    }
}
