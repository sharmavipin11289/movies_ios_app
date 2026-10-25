//
//  ContentView.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var flutter: FlutterCoordinator

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "film.stack")
                .font(.system(size: 64))
            Text("Movies")
                .font(.largeTitle.bold())
            Button("Show List of Movies") {
                flutter.showFlutter()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
