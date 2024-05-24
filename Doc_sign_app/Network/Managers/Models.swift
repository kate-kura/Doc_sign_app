//
//  Models.swift
//  Doc_sign_app
//
//  Created by Екатерина on 14.05.2024.
//

import Foundation

struct ContractModel: Decodable, Identifiable {
    let date: Int64
    let companyName: String
    let id: Int64
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case date = "created_at"
        case companyName = "first_party_name"
        case id = "id"
        case title = "title"
    }
}
