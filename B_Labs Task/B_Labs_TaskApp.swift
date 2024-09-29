//
//  B_Labs_TaskApp.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI
import Alamofire
import AlamofireEasyLogger

@main
struct B_Labs_TaskApp: App {
    
    let alamofireLogger = FancyAppAlamofireLogger(prettyPrint: true) {
        print($0)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeRouter.home
        }
    }
}
