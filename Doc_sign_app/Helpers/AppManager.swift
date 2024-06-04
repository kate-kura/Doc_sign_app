//
//  AppManager.swift
//  Doc_sign_app
//
//  Created by Екатерина on 12.04.2024.
//

import Foundation
import UIKit

class AppManager {
    
    //MARK: Settings
    
    static func basicDebugMode() -> Bool {
        return false
    }
    
    static func extendedDebugMode() -> Bool {
        return false
    }
    
    static func alamofireDebugMode() -> Bool {
        return true
    }
    
    static func viewDebugMode() -> Bool {
        return false
    }
    
    static func viewDidLoad(view: String) {
        if AppManager.extendedDebugMode() {
            Logg.err(.info, "\"\(view)\" View did load")
        }
    }
    
    static func viewDidUnload(view: String) {
        if AppManager.extendedDebugMode() {
            Logg.err(.info, "\"\(view)\" View did unload")
        }
    }
}
