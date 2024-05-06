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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
        
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            Logg.err(.error, "Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetaDataOutput)
            
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            vedioPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            vedioPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            vedioPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(vedioPreviewLayer!)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
            
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
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            massageLabel.text = Resources.Strings.qrText
            nextButton.isHidden = true
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let qrCodeObject = vedioPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = qrCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
//                massageLabel.text = metadataObj.stringValue
                nextButton.isHidden = false
            }
            
            if let qrCodeString = metadataObj.stringValue {
                let components = qrCodeString.components(separatedBy: "/")
                DefaultsHelper().setString(string: components.last ?? "", key: Resources.Keys.keyCurrentQRcodeID)
            }
        }
    }
    
    @objc private func didTapBack() {
        let vc = ContainerViewController()
        captureSession.stopRunning()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc private func didTapNext() {
        let vc = DocFromQRcodeViewController()
        captureSession.stopRunning()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
