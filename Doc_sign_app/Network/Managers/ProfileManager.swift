//
//  ProfileManager.swift
//  Doc_sign_app
//
//  Created by Екатерина on 07.05.2024.
//

import Foundation
import Alamofire

class ProfileManager {
    
    struct ProfileResultDecodable: Decodable {
        let error: String
        
        enum CodingKeys: String, CodingKey {
            case error = "error"
        }
    }
    
    struct ProfileDetailsDecodable: Decodable {
        let name: String
        let surname: String
        
        enum CodingKeys: String, CodingKey {
            case name = "first_name"
            case surname = "last_name"
        }
    }
    
    typealias BooleanCompletion = (Bool) -> Void
    
    typealias StatusCompletion = (Bool, Int) -> Void
    
    func getUserProfileDetails(completion: @escaping BooleanCompletion) {
        let token: String = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        ]
        
        Logg.err(.action, "Performing \"Get User Profile Details\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)!)...")
        
        AF.request(Resources.API.getUserProfileDetailsURL,
                   method: .get,
                   headers: headers).responseDecodable(of: ProfileDetailsDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "User Profile Details successfully got.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: resultDictionary.name, key: Resources.Keys.keyCurrentUserFirstName)
                DefaultsHelper().setString(string: resultDictionary.surname, key: Resources.Keys.keyCurrentUserLastName)
                DefaultsHelper().saveData()
                completion(result)
            case .failure(let error):
                Logg.err(.error, "Get User Profile Details failed with error \(String(describing: error))")
                let result = false
                completion(result)
            }
        }
    }
    
    func updateUserProfileDetails(firstName: String, lastName: String, completion: @escaping BooleanCompletion) {
        let token: String = DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: String] = [
            "first_name": firstName,
            "last_name": lastName
        ]
        
        Logg.err(.action, "Performing \"Update User Profile Details\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)!)...")
        
        AF.request(Resources.API.updateUserProfileDetailsURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: ProfileResultDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            if response.response?.statusCode == 200 {
                Logg.err(.success, "User Profile Details updated.")
                let result = true
                DefaultsHelper().setString(string: firstName, key: Resources.Keys.keyCurrentUserFirstName)
                DefaultsHelper().setString(string: lastName, key: Resources.Keys.keyCurrentUserLastName)
                completion(result)
            } else {
                Logg.err(.error, "Something wen't wrong during attempt to Update User Profile Details.")
                let result = false
                completion(result)
            }
        }
    }
}
