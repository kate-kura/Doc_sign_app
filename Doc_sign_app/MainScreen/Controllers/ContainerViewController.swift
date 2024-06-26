//
//  ContainerViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.03.2024.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    // Default menu State
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var profileVC = ProfileViewController1()
    lazy var qrCodeVC = QRcodeViewController()
    lazy var archiveVC = ArchiveViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Resources.Colors.white
        addChildVCs()
        
    }
}

extension ContainerViewController {
    
    // Adds child VCs to the container
    func addChildVCs() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

// MARK: - HomeViewControllerDelegate
extension ContainerViewController: HomeViewControllerDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    // Switch menu State
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            // Open menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            // Close menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
            
        }
    }
}

// MARK: - MenuViewControllerDelegate
extension ContainerViewController: MenuViewControllerDelegate {
    
    // Select menu item
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .profile:
            self.addProfile()
        case .qrCode:
            self.addQRcode()
        case .archive:
            self.addArchive()
        }

    }
    // Show ProfileViewController1
    func addProfile() {
        removeChildVCs()
        
        let vc = profileVC
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: self)
    }
    // Show QRcodeViewController
    func addQRcode() {
        removeChildVCs()
        
        let vc = qrCodeVC
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: self)
    }
    // Show ArchiveViewController
    func addArchive() {
        removeChildVCs()
        
        let vc = archiveVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    
    func removeChildVCs() {
        profileVC.view.removeFromSuperview()
        profileVC.removeFromParent()

        qrCodeVC.view.removeFromSuperview()
        qrCodeVC.removeFromParent()

        archiveVC.view.removeFromSuperview()
        archiveVC.removeFromParent()
    }
}
