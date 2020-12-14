//
//  FITstagramSwiftUIApp.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI

@main
struct FITstagramSwiftUIApp: App {
    init() {
        UserDefaults.standard.setValue("username", forKey: "username")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
