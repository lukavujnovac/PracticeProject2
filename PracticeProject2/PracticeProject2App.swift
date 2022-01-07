//
//  PracticeProject2App.swift
//  PracticeProject2
//
//  Created by Luka Vujnovac on 23.11.2021..
//

import SwiftUI

@main
struct PracticeProject2App: App {
    
    let currentUserSignedIn: Bool
    
    init() {
//        let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
//        let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
//        let userIsSignedIn: Bool = value == "true" ? true : false
        self.currentUserSignedIn = userIsSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
            UITestingBootcampView(currentUserSignedIn: currentUserSignedIn)
        }
    }
}
