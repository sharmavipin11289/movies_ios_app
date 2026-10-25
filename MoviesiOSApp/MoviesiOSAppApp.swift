//
//  MoviesiOSAppApp.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import SwiftUI

@main
struct MoviesiOSAppApp: App {
    @StateObject private var flutter = FlutterCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(flutter)
        }
    }
}
