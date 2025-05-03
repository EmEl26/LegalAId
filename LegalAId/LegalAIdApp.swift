//
//  LegalAIdApp.swift
//  LegalAId
//
//  Created by Celia Abuin on 4/28/25.
//

import SwiftUI


@main
struct LegalAId_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(authViewModel)
        }
    }
}


