//
//  wyr_appApp.swift
//  wyr_app
//
//  Created by Rodrigo Silva on 01/07/24.
//

import SwiftUI
import Firebase
import FirebaseRemoteConfig

@main
struct wyr_appApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        let rc = RemoteConfig.remoteConfig()

        WindowGroup {
            ContentView()
                .onAppear {
                    rc.fetchAndActivate()
                }
        }
    }
}
