//
//  AlertManager.swift
//  Doc_sign_app
//
//  Created by Екатерина on 11.04.2024.
//

import Foundation

import UIKit

class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

// MARK: - Show Validation Alerts
extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
    
    public static func defaultAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Error", message: nil)
    }

    public static func showPasswordMismatchAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Passwords Do Not Match", message: nil)
    }
    
    public static func showInvalidNameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Name", message: "Please enter the name using russian language.")
    }
    
    public static func showInvalidSurnameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Surname", message: "Please enter the surname using russian language.")
    }
}


// MARK: - Registration Errors
extension AlertManager {
    
    public static func showRegistrationErrorAlert403(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Registration Error", message: "User with provided email already exists")
    }
    
    public static func showVerifyCodeErrorAlert400(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Verification Code", message: "Please, enter a valid code.")
    }
}


// MARK: - Log In Errors
extension AlertManager {
    
    public static func showSignInErrorAlert401(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Error Signing In", message: "There is no user with such email address and password.")
    }
    
    public static func showSignInErrorAlert500(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Error Signing In", message: "Something has gone wrong on backend side")
    }
}


// MARK: - Logout Errors
extension AlertManager {
    
    public static func showLogoutError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}


// MARK: - Forgot Password
extension AlertManager {
    
    public static func showInvalidEmailFORPasswordReset403(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Password Reset Error", message: "There is no user with such an email address.")
    }
}


// MARK: - Fetching Backend Errors
extension AlertManager {
    
    public static func showFetchingBackendError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Application Error", message: "Please, reenter the app.")
    }
}


// MARK: - Fetching Camera Errors
extension AlertManager {
    
    public static func showCameraError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Camera Error", message: "Please, allow camera access.")
    }
}
