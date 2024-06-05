//
//  Validator.swift
//  Doc_sign_app
//
//  Created by Екатерина on 11.04.2024.
//

import Foundation

// MARK: - Email, Password, Name and Surname Validator
class Validator {
    
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isPasswordValid(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!-]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    static func isNameValid(for name: String) -> Bool {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nameRegEx = "(^[А-Я][а-я]*$)"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    static func isSurnameValid(for surname: String) -> Bool {
        let surname = surname.trimmingCharacters(in: .whitespacesAndNewlines)
        let surnameRegEx = "(^[А-Я][а-я]*$)"
        let surnamePred = NSPredicate(format: "SELF MATCHES %@", surnameRegEx)
        return surnamePred.evaluate(with: surname)
    }

}
