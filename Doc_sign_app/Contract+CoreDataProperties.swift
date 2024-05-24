//
//  Contract+CoreDataProperties.swift
//  Doc_sign_app
//
//  Created by Екатерина on 22.05.2024.
//
//

import Foundation
import CoreData

@objc(Contract)
public class Contract: NSManagedObject {}

extension Contract {
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var companyName: String?
    @NSManaged public var pdfURL: String?

}

extension Contract : Identifiable {

}
