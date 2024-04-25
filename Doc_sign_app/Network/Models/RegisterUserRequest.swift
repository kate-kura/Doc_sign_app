//
//  RegisterUserRequest.swift
//  Doc_sign_app
//
//  Created by Екатерина on 02.04.2024.
//

import Foundation

struct SignUpInitRequest: Codable {
    let email: String
    let password: String
    let type: String
}

struct SignUpCompletionRequest: Codable {
    let firstName: String
    let lastName: String
}

struct ApiResponse: Codable {
    let message: String
}
