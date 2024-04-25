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
    
//    static func debugMode() -> DebugMode {
//        // .none / .terse / .detailed
//        return .terse
//    }
    
    //MARK: Fun
//    static func windowManager(action: ActionType) {
//        switch action {
//        case .minimize:
//            print("")
//        case .close:
//            print("")
//        case .die:
//            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
//                exit(0)
//            }
//        }
//    }
    
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

//MARK: Usage

/*
 
 if AppManager.debugMode() {
 Logg.err(.debug, "Message")
 }
 
 */

/*
 
 AppManager.windowManager(.close)
 
 */
