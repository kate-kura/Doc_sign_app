//
//  AuthManager.swift
//  Doc_sign_app
//
//  Created by Екатерина on 11.04.2024.
//

import Foundation
import Alamofire

class AuthManager {
    
    struct AuthTokensDecodable: Decodable {
        let refresh: String
        let token: String
        
        enum CodingKeys: String, CodingKey {
            case refresh = "refresh"
            case token = "token"
        }
    }
    
    struct AuthTemporaryTokenDecodable: Decodable {
        let token: String
        
        enum CodingKeys: String, CodingKey {
            case token = "token"
        }
    }
    
    struct AuthResultDecodable: Decodable {
        let error: String
        
        enum CodingKeys: String, CodingKey {
            case error = "error"
        }
    }
    
    typealias BooleanCompletion = (Bool) -> Void
    
    typealias StatusCompletion = (Bool, Int) -> Void
    
    // MARK: - Signing In
    func signIn(email: String, password: String, completion: @escaping StatusCompletion) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        Logg.err(.action, "Performing \"Sign In\" request for \(email)...")
        
        AF.request(Resources.API.signInURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: AuthTokensDecodable.self) { response in
            Logg.err(.AFdebug, response.debugDescription as String)
            var statusCode = 0
            switch response.response?.statusCode {
            case 200: statusCode = 200
            case 400: statusCode = 400
            case 401: statusCode = 401
            case 500: statusCode = 500
            case .none: statusCode = -1
            case .some(_): statusCode = -1
            }
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Signed In.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: email, key: Resources.Keys.keyCurrentUserEmail)
                DefaultsHelper().setString(string: resultDictionary.token, key: Resources.Keys.keyCurrentUserAuthToken)
                DefaultsHelper().setString(string: resultDictionary.refresh, key: Resources.Keys.keyCurrentUserRefreshToken)
                completion(result, statusCode)
            case .failure(let error):
                Logg.err(.error, error.localizedDescription)
                let result = false
                completion(result, statusCode)
            }
        }
    }
    
    // MARK: - Signing Up
    func signUp(email: String, password: String, completion: @escaping BooleanCompletion) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        Logg.err(.action, "Performing \"Sign Up\" request for \(email)...")
        
        AF.request(Resources.API.registrationURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: AuthResultDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            if response.response?.statusCode == 200 {
                Logg.err(.success, "Signed Up.")
                let result = true
                DefaultsHelper().setString(string: email, key: Resources.Keys.keyCurrentUserEmail)
                completion(result)
            } else {
                Logg.err(.error, "Something wen't wrong during attempt to Sign Up.")
                let result = false
                completion(result)
            }
        }
    }
    
    func confirmSignUp(code: String, completion: @escaping BooleanCompletion) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        Logg.err(.action, "Performing \"Confirm Account\" request for \(code)...")
        
        AF.request (Resources.API.confirmRegistrationURL + code,
                    method: .get,
                    headers: headers).responseDecodable(of: AuthTemporaryTokenDecodable.self) { response in
            Logg.err(.AFdebug, response.debugDescription as String)
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Account confirmed.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: resultDictionary.token, key: Resources.Keys.keyTemporaryUserAuthToken)
                completion(result)
            case .failure(let error):
                Logg.err(.error, "Account confirmation failed with error \(String(describing: error))")
                let result = false
                completion(result)
            }
        }
    }
    
    
    func completeSignUp(firstName: String, lastName: String, completion: @escaping StatusCompletion) {
        let token: String = DefaultsHelper().getString(key: Resources.Keys.keyTemporaryUserAuthToken)!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: String] = [
            "first_name": firstName,
            "last_name": lastName
        ]
        
        Logg.err(.action, "Performing \"Complete SignUp Account\" request for \(firstName + " " + lastName)...")
        
        AF.request(Resources.API.completeRegistrationURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: AuthTokensDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            var statusCode = 0
            switch response.response?.statusCode {
            case 200: statusCode = 200
            case 400: statusCode = 400
            case 401: statusCode = 401
            case 500: statusCode = 500
            case .none: statusCode = -1
            case .some(_): statusCode = -1
            }
            
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Account registration completed.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: firstName, key: Resources.Keys.keyCurrentUserFirstName)
                DefaultsHelper().setString(string: lastName, key: Resources.Keys.keyCurrentUserLastName)
                DefaultsHelper().setString(string: resultDictionary.refresh, key: Resources.Keys.keyCurrentUserAuthToken)
                DefaultsHelper().setString(string: resultDictionary.token, key: Resources.Keys.keyCurrentUserRefreshToken)
                completion(result, statusCode)
            case .failure(let error):
                Logg.err(.error, error.localizedDescription)
                let result = false
                completion(result, statusCode)
            }
        }
    }
    
    // MARK: - Refresh Token
    func refreshTokens(completion: @escaping BooleanCompletion) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        let parameters: [String: String] = [
            "refresh": DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserRefreshToken)!
        ]
        
        Logg.err(.action, "Performing \"Refresh Auth Token\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)!)...")
        
        AF.request(Resources.API.refreshTokenURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: AuthTokensDecodable.self) { response in
            Logg.err(.AFdebug, response.debugDescription as String)
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Auth token refreshed.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: resultDictionary.refresh, key: Resources.Keys.keyCurrentUserRefreshToken)
                DefaultsHelper().setString(string: resultDictionary.token, key: Resources.Keys.keyCurrentUserAuthToken)
                completion(result)
            case .failure(let error):
                Logg.err(.error, "Refresh failed with error \(String(describing: error))")
                let result = false
                completion(result)
            }
        }
    }
    
    // MARK: - Change Password
    func changePassword(email: String, completion: @escaping BooleanCompletion) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        let parameters: [String: String] = [
            "email": email
        ]
        
        Logg.err(.action, "Performing \"Restore Password\" request for \(email)...")
        
        AF.request(Resources.API.changePasswordURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: AuthResultDecodable.self) { response in
            Logg.err(.AFdebug, response.debugDescription as String)
            if response.response?.statusCode == 200 {
                Logg.err(.success, "Password reset successfully.")
                DefaultsHelper().setString(string: email, key: Resources.Keys.keyCurrentUserEmail)
                let result = true
                completion(result)
            } else {
                Logg.err(.error, "Something wen't wrong during attempt to Reset Password.")
                let result = false
                completion(result)
            }
        }
    }
    
    func confirmChangePassword(code: String, completion: @escaping BooleanCompletion) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        Logg.err(.action, "Performing \"Confirm Account\" request for \(code)...")
        
        AF.request (Resources.API.confirmChangePasswordURL + code,
                    method: .get,
                    headers: headers).responseDecodable(of: AuthTemporaryTokenDecodable.self) { response in
            Logg.err(.AFdebug, response.debugDescription as String)
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Account confirmed.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: resultDictionary.token, key: Resources.Keys.keyTemporaryUserAuthToken)
                completion(result)
            case .failure(let error):
                Logg.err(.error, "Account confirmation failed with error \(String(describing: error))")
                let result = false
                completion(result)
            }
        }
    }
    
    func completeChangePassword(password: String, repeatPassword: String, completion: @escaping StatusCompletion) {
        let token: String = DefaultsHelper().getString(key: Resources.Keys.keyTemporaryUserAuthToken)!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: String] = [
            "password": password,
            "repeat_password": repeatPassword
        ]
        
        Logg.err(.action, "Performing \"Complete Changing Password\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)!)...")
        
        AF.request(Resources.API.setNewPasswordURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: AuthTokensDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            var statusCode = 0
            switch response.response?.statusCode {
            case 200: statusCode = 200
            case 400: statusCode = 400
            case 401: statusCode = 401
            case 403: statusCode = 403
            case 500: statusCode = 500
            case 502: statusCode = 502
            case .none: statusCode = -1
            case .some(_): statusCode = -1
            }
            
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Account registration completed.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: resultDictionary.refresh, key: Resources.Keys.keyCurrentUserAuthToken)
                DefaultsHelper().setString(string: resultDictionary.token, key: Resources.Keys.keyCurrentUserRefreshToken)
                completion(result, statusCode)
            case .failure(let error):
                Logg.err(.error, error.localizedDescription)
                let result = false
                completion(result, statusCode)
            }
        }
    }
}

extension AuthManager {
    
    // MARK: - Checks if auth token is still valid and refreshes if needed
    func checkAuth(completion: @escaping BooleanCompletion) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
            "Accept": "application/json",
        ]
        
        Logg.err(.action, "Checking authorization...")
        
        AF.request(Resources.API.getUserProfileDetailsURL,
                   method: .get,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .response { response in
            

            switch response.result {
            case .success(_):
                Logg.err(.success, "Auth token is still valid.")
                completion(true)
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 401:
                        print("401")
                        Logg.err(.debug, "Error 401 - Unauthorized: \(error.localizedDescription)\nToken probably expired.")
                        self.refreshTokens { success in
                            if !success {
                                DefaultsHelper().setBoolean(boolean: false, key: Resources.Keys.keyCheckIfSignedIn)
                                DefaultsHelper().removeObject(forKey: Resources.Keys.keyCurrentUserProfileImage)
                            }
                            completion(success)
                        }
                    case 500:
                        Logg.err(.error, "Error 500 - Internal Server Error: \(error.localizedDescription)\nBackend probably died or app sent some very wrong data.")
                        completion(false)
                    default:
                        Logg.err(.error, "Unexpected error with status code \(statusCode): \(error.localizedDescription)")
                        completion(false)
                    }
                } else {
                    Logg.err(.error, "Unexpected error: \(error)")
                    completion(false)
                }
            }
        }
    }
}
