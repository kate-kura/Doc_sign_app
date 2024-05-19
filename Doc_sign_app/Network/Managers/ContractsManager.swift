//
//  ContractsManager.swift
//  Doc_sign_app
//
//  Created by Екатерина on 14.05.2024.
//

import Foundation
import Alamofire

class ContractsManager {
    
    struct ContractsResultDecodable: Decodable {
        let error: String
        
        enum CodingKeys: String, CodingKey {
            case error = "error"
        }
    }
    
//    struct ContractsDetailsDecodable: Decodable {
//        let id: Int
//        let title: String
//        
//        enum CodingKeys: String, CodingKey {
//            case id = "id"
//            case title = "title"
//        }
//    }
    
//    struct TemplatesListDecodable: Decodable {
//        let templates: [ContractModel]
//        
//        enum CodingKeys: String, CodingKey {
//            case templates = "templates"
//        }
//    }
    
//    struct ContractContentDecodable: Decodable {
//        let id: Int
//        let templateId: Int
//        let text: String
//        let title: String
//        
//        enum CodingKeys: String, CodingKey {
//            case id = "id"
//            case templateId = "template_id"
//            case text = "text"
//            case title = "title"
//        }
//    }
    
    struct FormContentDecodable: Decodable {
        let firstPartyName: String
        let formFields: [String]
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case firstPartyName = "first_party_name"
            case formFields = "form_fields"
            case title = "form_title"
        }
    }
    
    struct FormFieldsDecodable: Decodable {
        let formID: Int
        let initiatingPartyKeys: [String]

        enum CodingKeys: String, CodingKey {
            case formID = "form_id"
            case initiatingPartyKeys = "initiating_party_keys"
        }
    }
    
    typealias BooleanCompletion = (Bool) -> Void
    
    typealias StatusCompletion = (Bool, Int) -> Void
    
//    func getListOfContracts(completion: @escaping BooleanCompletion) {
//        
//        AuthManager().checkAuth()
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
//            "Content-Type": "application/json"
//        ]
//        
//        Logg.err(.action, "Performing \"Get List of Contracts\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)!)...")
//        
//        AF.request(Resources.API.getListOfContractsURL,
//                   method: .get,
//                   headers: headers).responseDecodable(of: TemplatesListDecodable.self) {response in
//            Logg.err(.AFdebug, response.debugDescription as String)
//            switch response.result {
//            case .success(let JSONResult):
//                Logg.err(.success, "List of Contracts successfully got.")
//                let result = true
//                let resultDictionary = JSONResult
////                DefaultsHelper().setString(string: resultDictionary.name, key: Resources.Keys.keyCurrentUserFirstName)
////                DefaultsHelper().setString(string: resultDictionary.surname, key: Resources.Keys.keyCurrentUserLastName)
//                completion(result)
//            case .failure(let error):
//                Logg.err(.error, "Get List of Contracts failed with error \(String(describing: error))")
//                let result = false
//                completion(result)
//            }
//        }
//    }
    
//    func getPDFContract(completion: @escaping BooleanCompletion) {
//        
//        AuthManager().checkAuth()
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
//            "Content-Type": "application/json"
//        ]
//        
//        Logg.err(.action, "Performing \"Get PDF Contract\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!)...")
//        
//        let destination: DownloadRequest.Destination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendingPathComponent("contract\(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!).pdf")
//
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
//        
//        AF.download(Resources.API.getPDFContractURL + DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!,
//                    headers: headers,
//                    to: destination).responseDecodable(of: ContractsResultDecodable.self) {response in
//            Logg.err(.AFdebug, response.debugDescription as String)
//            if response.response?.statusCode == 200 {
//                Logg.err(.success, "PDF Contract successfully downloaded at: \(response.fileURL?.path ?? "")")
//                let result = true
//                completion(result)
//            } else {
//                Logg.err(.error, "Get PDF Contract failed with error")
//                let result = false
//                completion(result)
//            }
//        }
//    }
    
//    func getContractContent(completion: @escaping BooleanCompletion) {
//        
//        AuthManager().checkAuth()
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
//            "Content-Type": "application/json"
//        ]
//        
//        Logg.err(.action, "Performing \"Get Contract Content\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!)...")
//        
//        AF.request(Resources.API.getContractContentURL + DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!,
//                   method: .get,
//                   headers: headers).responseDecodable(of: ContractContentDecodable.self) {response in
//            Logg.err(.AFdebug, response.debugDescription as String)
//            switch response.result {
//            case .success(let JSONResult):
//                Logg.err(.success, "Contract Content successfully got.")
//                let result = true
//                let resultDictionary = JSONResult
////                DefaultsHelper().setInteger(integer: resultDictionary.id, key: <#T##String#>)
////                
////                DefaultsHelper().setString(string: resultDictionary.templateId, key: Resources.Keys.keyCurrentUserFirstName)
////                DefaultsHelper().setString(string: resultDictionary.surname, key: Resources.Keys.keyCurrentUserLastName)
//                completion(result)
//            case .failure(let error):
//                Logg.err(.error, "Get Contract Content failed with error \(String(describing: error))")
//                let result = false
//                completion(result)
//            }
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getFormContentFromQR(completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth()
   
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
            "Content-Type": "application/json"
        ]
        
        Logg.err(.action, "Performing \"Get Form Content\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!)...")
        
        AF.request (Resources.API.getFormContentURL + DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!,
                   method: .get,
                   headers: headers).responseDecodable(of: FormContentDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Form Content successfully got.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setString(string: resultDictionary.firstPartyName, key: Resources.Keys.keyCurrentQRdocCompany)
                DefaultsHelper().setString(string: resultDictionary.title, key: Resources.Keys.keyCurrentQRdocTitle)
                DefaultsHelper().setStringArray(stringArray: resultDictionary.formFields, key: Resources.Keys.keyCurrentFormFields)
                completion(result)
            case .failure(let error):
                Logg.err(.error, "Get Form Content failed with error \(String(describing: error))")
                let result = false
                completion(result)
            }
        }
    }
    
    func getPDFForm(completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!
        ]
        
        Logg.err(.action, "Performing \"Get PDF Form\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!)...")
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("contract\(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!).pdf")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(Resources.API.getPDFFormURL + DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!,
                    headers: headers,
                    to: destination).responseDecodable(of: ContractsResultDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            if response.response?.statusCode == 200 {
                Logg.err(.success, "PDF Form successfully downloaded at: \(response.fileURL?.path ?? "")")
                let result = true
                completion(result)
            } else {
                Logg.err(.error, "Get PDF Form failed with error")
                let result = false
                completion(result)
            }
        }
    }
    
    func getFormFields(completion: @escaping BooleanCompletion) {
    
        AuthManager().checkAuth()
   
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
            "Content-Type": "application/json"
        ]
        
        Logg.err(.action, "Performing \"Get Form Fields\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!)...")
        
        AF.request (Resources.API.getFormFieldsURL + DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!,
                   method: .get,
                   headers: headers).responseDecodable(of: FormFieldsDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            switch response.result {
            case .success(let JSONResult):
                Logg.err(.success, "Form Fields successfully got.")
                let result = true
                let resultDictionary = JSONResult
                DefaultsHelper().setInteger(integer: resultDictionary.formID, key: Resources.Keys.keyCurrentFormID)
                DefaultsHelper().setStringArray(stringArray: resultDictionary.initiatingPartyKeys, key: Resources.Keys.keyCurrentBackendFormFields)
                completion(result)
            case .failure(let error):
                Logg.err(.error, "Get Form Content failed with error \(String(describing: error))")
                let result = false
                completion(result)
            }
        }
    }
    
    func fillFormFields(respondingPartyKeys: [String: String], completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
            "Content-Type": "application/json"
        ]
        
        struct FormFieldsParameters: Encodable {
            let form_id: Int
            let responding_party_keys: [String: String]
        }
        
        let parameters = FormFieldsParameters(form_id: DefaultsHelper().getInteger(key: Resources.Keys.keyCurrentFormID)!, responding_party_keys: respondingPartyKeys)
        
        Logg.err(.action, "Performing \"Fill Form Fields\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentQRcodeID)!)...")
        
        AF.request(Resources.API.fillFormFieldsURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: ContractsResultDecodable.self) {response in
            Logg.err(.AFdebug, response.debugDescription as String)
            if response.response?.statusCode == 200 {
                Logg.err(.success, "Form Fields successfully filled.")
                let result = true
                completion(result)
            } else {
                Logg.err(.error, "Fill Form Content failed with error")
                let result = false
                completion(result)
            }
        }
    }
    
}

