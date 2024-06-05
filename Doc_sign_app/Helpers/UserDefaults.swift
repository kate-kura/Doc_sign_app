//
//  UserDefaults.swift
//  Doc_sign_app
//
//  Created by Екатерина on 12.04.2024.
//

import Foundation

 //MARK: UserDefaults class
class DefaultsHelper {
    
    let defaults = UserDefaults.standard
    

    // Save value of String type for specified key
    func setString(string: String, key: String) {
        defaults.set(string, forKey: key)
    }
    
    // Save value of Integer type for specified key
    func setInteger(integer: Int, key: String) {
        defaults.set(integer, forKey: key)
    }
    
    // Save value of Integer64 type for specified key
    func setInteger64(integer64: Int64, key: String) {
        defaults.set(NSNumber(value: integer64), forKey: key)
    }

    //Save value of Boolean type for specified key
    func setBoolean(boolean: Bool, key: String) {
        defaults.set(boolean, forKey: key)
    }
    
    // Save value of [String] type for specified key
    func setStringArray(stringArray: [String], key: String) {
        defaults.set(stringArray, forKey: key)
    }
    
    // Method to save String/Integer/Integer64/Boolean/[String] type value for specified key
    func set(string: String? = nil, integer: Int? = nil, integer64: Int64? = nil, boolean: Bool? = nil, stringArray: [String]? = nil, key: String) { //Attempt to create a universal one
        if string != nil {
            defaults.set(string, forKey: key)
        } else if integer != nil {
            defaults.set(integer, forKey: key)
        } else if integer64 != nil {
            defaults.set(integer, forKey: key)
        } else if boolean != nil {
            defaults.set(boolean, forKey: key)
        } else if stringArray != nil {
            defaults.set(stringArray, forKey: key)
        }
    }
    

    // Retrieve a string for specified key.
    func getString(key: String) -> String? {
        return defaults.string(forKey: key) ?? "N/a" //Can return nil
    }

    // Retrieve an integer for specified key
    func getInteger(key: String) -> Int? {
        return defaults.integer(forKey: key)
    }
    
    func getInteger64(key: String) -> Int64 {
        return defaults.object(forKey: key) as? Int64 ?? 0
    }

    // Retrieve a boolean for specified key
    func getBoolean(key: String) -> Bool? {
        return defaults.bool(forKey: key)
    }
    
    // Retrieve a string array for specified key
    func getStringArray(key: String) -> [String]? {
        return defaults.stringArray(forKey: key)
    }
    
    
    // Delete UserDefaults data
    func removePersistentDomain() {
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
            defaults.synchronize()
        }
    }
    
    func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }

}

