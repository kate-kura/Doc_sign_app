//
//  Debugger.swift
//  Doc_sign_app
//
//  Created by Екатерина on 16.04.2024.
//

import Foundation

struct Debugger {
    
    // Checks "wasLaunchedBefore" and "isLoggedIn" variables from UserDefaults and logs to console.
    // Returns (wasLaunchedBefore, isLoggedIn) which is (Bool, Bool)
    
    @discardableResult
    func checkOnLaunch() -> (Bool, Bool) {
        let wasLaunchedBefore = DefaultsHelper().getBoolean(key: Resources.Keys.keyCheckFirstLaunch)!
        let isLoggedIn = DefaultsHelper().getBoolean(key: Resources.Keys.keyCheckIfSignedIn)!
        
        Logg.err(.debug, "\"wasLaunchedBefore\" is \"\(wasLaunchedBefore ? "true ✅" : "false ❌")\", \"isLoggedIn\" is \"\(isLoggedIn ? "true ✅" : "false ❌")\"")
        
        return (wasLaunchedBefore, isLoggedIn)
    }
}
