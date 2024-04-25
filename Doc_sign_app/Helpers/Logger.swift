//
//  Logger.swift
//  Doc_sign_app
//
//  Created by Екатерина on 11.04.2024.
//

enum LogMessageType: String {
    case action
    case success
    case info
    case warning
    case error
    case debug
    case AFdebug
    case viewDebug
    case settings
}

class Logg {
    static func err(_ messageType: LogMessageType, _ message: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        switch messageType {
        case LogMessageType.action:
            print(" 🔵 Action: \(message)")
        case LogMessageType.success:
            print(" 🟢 Success: \(message)")
        case LogMessageType.info:
            print(" 🟡 Info: \(message)")
        case LogMessageType.warning:
            print(" 🟠 Warning: \(message)")
        case LogMessageType.error:
            print(" 🔴 Error: \(message)\nOccured in \(file) at line \(line)") //~~FIXME:~~ Occured in .../Logger.swift at line 31 //MARK: Should work correct now
        case LogMessageType.debug:
            print(" 🟣 DEBUG: \(message)")
        case LogMessageType.AFdebug:
            if AppManager.alamofireDebugMode() {
                print(" 🟣 Alamofire debug log below:")
                print(message)
                print(" 🟣 EOF.")
            }
        case LogMessageType.viewDebug:
            if AppManager.viewDebugMode() {
                print(" 🟣 View: \(message) 🟣")
            }
        case LogMessageType.settings:
            print(" ⚪️ Settings: \(message)")
        }
    }
}
