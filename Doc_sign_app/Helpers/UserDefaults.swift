//
//  UserDefaults.swift
//  Doc_sign_app
//
//  Created by Екатерина on 12.04.2024.
//

import Foundation

/*: Wiki
 
 //MARK: UserDefaults Wiki
 
 SET
 String — UserDefaults.standard.set("String", forKey: "Key")
 Integer — UserDefaults.standard.set(42, forKey: "Key")
 Boolean — UserDefaults.standard.set(true, forKey: "Key")
 
 SHORTCUT
 let defaults = UserDefaults.standard
 THEN defaults.set("String", forKey: "Key")
 
 GET
 String — let result = UserDefaults.standard.string(forKey: "key")
 - Will return Optional("String") if found string for key
 - Will return Optional("42") if found int for key
 - Will return Optional("1") or Optional("0") for true/false if found boolean for key
 - Will return nil if didn't found any for key
 - Will return non-optional content if unwrapped with ??
 
 Integer — let result = UserDefaults.standard.integer(forKey: "key")
 - Will return 42 if found number for key
 - Will return 0 if found string for key
 - Will return 1 or 0 for true/false if found boolean for key
 - Will return 0 if didn't found any for key
 
 Boolean — let result = UserDefaults.standard.bool(forKey: "key")
 - Will return true or false if found boolean for key
 - Will return true if found int >= 1 and false if int <= 0 for key
 - Will return Optional("1") or Optional("0") for true/false if found bool for key
 - Will return false if didn't found any for key
 
 */

//: [Next topic](@next)

/**
 The DefaultsHelper class provides more convenient methods for interacting with the defaults system (user’s defaults key-value database).
 User’s defaults are stored locally on a single device. For more - see https://developer.apple.com/documentation/foundation/userdefaults
 */
class DefaultsHelper {
    
    /**
     Shortcut to UserDefaults.standard
     */
    let defaults = UserDefaults.standard
    
    /**
     Save value of String type for specified key
     */
    func setString(string: String, key: String) {
        defaults.set(string, forKey: key)
    }
    
    /**
     Save value of Integer type for specified key. _Not very much sense to save_ **0** _since it is default value which you get if you try to retrieve Integer for non-existent key, instead of nil in case of getting string._
     */
    func setInteger(integer: Int, key: String) {
        defaults.set(integer, forKey: key)
    }
    
    /**
     Save value of Boolean type for specified key. _Not very much sense to save_ **false** _since it is default value which you get if you try to retrieve Boolean for non-existent key, instead of nil in case of getting string._
     */
    func setBoolean(boolean: Bool, key: String) {
        defaults.set(boolean, forKey: key)
    }
    
    /**
     Some more universal method to save String/Integer/Boolean type value for specified key. _Caveat - pass only one arg because only first one will be saved._
     */
    func set(string: String? = nil, integer: Int? = nil, boolean: Bool? = nil, key: String) { //Attempt to create a universal one
        if string != nil {
            defaults.set(string, forKey: key)
        } else if integer != nil {
            defaults.set(integer, forKey: key)
        } else if boolean != nil {
            defaults.set(boolean, forKey: key)
        }
    }
    
    /**
     Retrieve a string for specified key. _Always return_ **Optional** _if found anything and_ **nil** _if nothing found for specified key. Will return_ **"1"** _or_ **"0"** _for_ **true**_/_**false** _if retrieved value were saved as Boolean. Most nice way to unwrap is to provide a default value with_ **?? "Default"**.
     */
    func getString(key: String) -> String? {
        return defaults.string(forKey: key) ?? "N/a" //Can return nil
    }
    
    /**
     Retrieve an integer for specified key. _Will return_ **1** _or_ **0** _for_ **true**_/_**false** _if found_ **Boolean**_, and_ **0** _instead of_ **nil** _if fnothing found for specified key._
     */
    func getInteger(key: String) -> Int? {
        return defaults.integer(forKey: key)
    }
    
    /**
     Retrieve a boolean for specified key. _Will return_ **0** _instead of_ **nil** _if fnothing found for specified key._
     */
    func getBoolean(key: String) -> Bool? {
        return defaults.bool(forKey: key)
    }
    
    //    typealias StringOrBoolean = (string: String?, integer: Int?, boolean: Bool?) //Hello again, tuple
    //
    //    func get(key: String) -> StringOrBoolean {
    //        return (defaults.string(forKey: key), defaults.integer(forKey: key), defaults.bool(forKey: key))
    //    }
    // ^ Attempt to create a universal one, not finished - will need extra functions or extra code to unpack tuple
    
    func removePersistentDomain() {
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
            defaults.synchronize()
        }
    }
    
}

/*
 
 //MARK: Usage
 
 setString(string: "String", key: "Key")
 
 setInteger(integer: 42, key: "Key")
 
 setBoolean(boolean: true, key: "Key")
 
 set(string: "String", key: "Key")
 
 set(integer: 42, key: "Key")
 
 set(boolean: true, key: "Key")
 
 */
