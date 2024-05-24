//
//  DatabaseManager.swift
//  Doc_sign_app
//
//  Created by Екатерина on 14.05.2024.
//

import UIKit
import CoreData

public final class DatabaseManager: NSObject {
    public static let shared = DatabaseManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //из кью ар кода и при авторизации список контрактов
    public func createContract(_ id: Int64, title: String, companyName: String) {
        guard let contractEntityDecsription = NSEntityDescription.entity(forEntityName: "Contract", in: context) else {return}
        let contract = Contract(entity: contractEntityDecsription, insertInto: context)
        contract.id = id
        contract.title = title
        contract.companyName = companyName
        
        appDelegate.saveContext()
    }
    
    public func createContractPDF(_ id: Int64, pdf: String) {
        guard let contractEntityDecsription = NSEntityDescription.entity(forEntityName: "Contract", in: context) else {return}
        let contract = Contract(entity: contractEntityDecsription, insertInto: context)
        contract.id = id
        contract.pdfURL = pdf
        
        appDelegate.saveContext()
    }
    
    //  получить все контракты чтобы установить количество cell
    public func fetchContracts() -> [Contract] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contract")
        do {
            return (try? context.fetch(fetchRequest) as? [Contract]) ?? []
        } 
    }
    
    //получить info по айди
    public func fetchContract(with id: Int64) -> Contract? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contract")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let contracts = try? context.fetch(fetchRequest) as? [Contract]
            return contracts?.first
        }
    }
    
    public func deleteContract(with id: Int64) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contract")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let contracts = try? context.fetch(fetchRequest) as? [Contract],
                  let contract = contracts.first else {return}
            context.delete(contract)
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteAllContracts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contract")
        do {
            let contracts = try? context.fetch(fetchRequest) as? [Contract]
            contracts?.forEach{context.delete($0)}
        }
        
        appDelegate.saveContext()
    }
}
