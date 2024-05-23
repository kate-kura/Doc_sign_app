//
//  Contract+CoreDataProperties.swift
//  Doc_sign_app
//
//  Created by Екатерина on 22.05.2024.
//
//

import Foundation
import CoreData


extension Contract {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contract> {
        return NSFetchRequest<Contract>(entityName: "Contract")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var companyName: String?
    @NSManaged public var pdf: Data?

}

extension Contract : Identifiable {

}
