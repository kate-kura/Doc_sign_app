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
    
    struct ContractContentDecodable: Decodable {
        let title: String
        let date: Int64
        let firstPart: String
        let secondPart: String
        
        enum CodingKeys: String, CodingKey {
            case title = "contract_title"
            case date = "date"
            case firstPart = "first_party_name"
            case secondPart = "second_party_name"
        }
    }
    
    struct ContractIDDecodable: Decodable {
        let id: Int64
        
        enum CodingKeys: String, CodingKey {
            case id = "contract_id"
        }
    }
    
    struct ContractsListDecodable: Decodable {
        let contracts_info: [ContractModel]
        
        enum CodingKeys: String, CodingKey {
            case contracts_info = "contracts"
        }
    }
    
    struct FormContentDecodable: Decodable {
        let filename: String
        let firstPartyName: String
        let formFields: [String]
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case filename = "filename"
            case firstPartyName = "first_party_name"
            case formFields = "form_fields"
            case title = "form_title"
        }
    }
    //!!!!!!!!!!!!!!!!!!!!!
    struct FormFieldsDecodable: Decodable {
        let formID: Int
        let formFields: [String]

        enum CodingKeys: String, CodingKey {
            case formID = "form_id"
            case formFields = "form_fields"
        }
    }
    
    typealias BooleanCompletion = (Bool) -> Void

    typealias ContractsCompletion = ([ContractModel]?, Error?) -> Void
    
//    AuthManager().checkAuth{ success in
//        if success {
//            
//        } else {
//            Logg.err(.error, "Token refresh failed. Cannot update user profile details.")
//            let result = false
//            completion(result)
//        }
//    }
    
    func getListOfContracts(completion: @escaping ContractsCompletion) {
        
        AuthManager().checkAuth{ success in
            if success {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
                    "Content-Type": "application/json"
                ]
                
                Logg.err(.action, "Performing \"Get List of Contracts\" request for \(DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserEmail)!)...")
                
                AF.request(Resources.API.getListOfContractsURL,
                           method: .get,
                           headers: headers).responseDecodable(of: ContractsListDecodable.self) {response in
                    Logg.err(.AFdebug, response.debugDescription as String)
                    switch response.result {
                    case .success(let JSONResult):
                        Logg.err(.success, "List of Contracts successfully got.")
                        let resultDictionary = JSONResult.contracts_info
                        var contracts = [ContractModel]()
                        DatabaseManager.shared.deleteAllContracts()
                        for item in resultDictionary {
                            let contract = ContractModel(date: item.date, companyName: item.companyName, id: item.id, title: item.title)
                            DatabaseManager.shared.createContract(item.id, title: item.title, companyName: item.companyName)
                            contracts.append(contract)
                        }
                        completion(contracts, nil)
                    case .failure(let error):
                        Logg.err(.error, "Get List of Contracts failed with error \(String(describing: error))")
                        completion(nil, error)
                    }
                }
            } else {
                Logg.err(.error, "Token refresh failed.")
//                let result = false
//                completion(result)
            }
        }
    }
    
    func getPDFContract(id: Int64, completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth{ success in
            if success {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
                    "Content-Type": "application/pdf"
                ]
                
                Logg.err(.action, "Performing \"Get PDF Contract\" request for \(id)...")
                
                let destination: DownloadRequest.Destination = { _, _ in
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let fileURL = documentsURL.appendingPathComponent("contractOptional(\(String(describing: id))).pdf")
                    
                    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                }
                
                AF.download(Resources.API.getPDFContractURL + String(id),
                            headers: headers,
                            to: destination).responseDecodable(of: ContractsResultDecodable.self) {response in
                    Logg.err(.AFdebug, response.debugDescription as String)
                    if response.response?.statusCode == 200 {
                        Logg.err(.success, "PDF Contract successfully downloaded at: \(response.fileURL?.path ?? "")")
                        let result = true
                        completion(result)
                    } else {
                        Logg.err(.error, "Get PDF Contract failed with error")
                        let result = false
                        completion(result)
                    }
                }
            } else {
                Logg.err(.error, "Token refresh failed.")
                let result = false
                completion(result)
            }
        }
    }
    
    func getContractContent(completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth{ success in
            if success {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer " + DefaultsHelper().getString(key: Resources.Keys.keyCurrentUserAuthToken)!,
                    "Content-Type": "application/json"
                ]
                
                Logg.err(.action, "Performing \"Get Contract Content\" request for \(DefaultsHelper().getInteger64(key: Resources.Keys.keyCurrentContractID))...")
                
                AF.request(Resources.API.getContractContentURL + String(DefaultsHelper().getInteger64(key: Resources.Keys.keyCurrentContractID)),
                           method: .get,
                           headers: headers).responseDecodable(of: ContractContentDecodable.self) {response in
                    Logg.err(.AFdebug, response.debugDescription as String)
                    switch response.result {
                    case .success(let JSONResult):
                        Logg.err(.success, "Contract Content successfully got.")
                        let result = true
                        let resultDictionary = JSONResult
                        DatabaseManager.shared.createContract(DefaultsHelper().getInteger64(key: Resources.Keys.keyCurrentContractID), title: resultDictionary.title, companyName: resultDictionary.firstPart)
                        completion(result)
                    case .failure(let error):
                        Logg.err(.error, "Get Contract Content failed with error \(String(describing: error))")
                        let result = false
                        completion(result)
                    }
                }
            } else {
                Logg.err(.error, "Token refresh failed. Cannot update user profile details.")
                let result = false
                completion(result)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getFormContentFromQR(completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth{ success in
            if success {
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
            } else {
                Logg.err(.error, "Token refresh failed.")
                let result = false
                completion(result)
            }
        }
    }
    
    func getPDFForm(completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth{ success in
            if success {
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
            } else {
                Logg.err(.error, "Token refresh failed.")
                let result = false
                completion(result)
            }
        }
    }
    
    func getFormFields(completion: @escaping BooleanCompletion) {
    
        AuthManager().checkAuth{ success in
            if success {
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
                        DefaultsHelper().setStringArray(stringArray: resultDictionary.formFields, key: Resources.Keys.keyCurrentBackendFormFields)
                        completion(result)
                    case .failure(let error):
                        Logg.err(.error, "Get Form Fields failed with error \(String(describing: error))")
                        let result = false
                        completion(result)
                    }
                }
            } else {
                Logg.err(.error, "Token refresh failed.")
                let result = false
                completion(result)
            }
        }
    }
    
    func fillFormFields(respondingPartyKeys: [String: String], completion: @escaping BooleanCompletion) {
        
        AuthManager().checkAuth{ success in
            if success {
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
                           headers: headers).responseDecodable(of: ContractIDDecodable.self) {response in
                    Logg.err(.AFdebug, response.debugDescription as String)
                    switch response.result {
                    case .success(let JSONResult):
                        Logg.err(.success, "Form Fields successfully filled.")
                        let result = true
                        let resultDictionary = JSONResult
                        DefaultsHelper().setInteger64(integer64: resultDictionary.id, key: Resources.Keys.keyCurrentContractID)
                        completion(result)
                    case .failure(_):
                        Logg.err(.error, "Fill Form Fields failed with error")
                        let result = false
                        completion(result)
                    }
                }
            } else {
                Logg.err(.error, "Token refresh failed.")
                let result = false
                completion(result)
            }
        }
    }
}

