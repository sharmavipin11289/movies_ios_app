//
//  TrailerView.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import SwiftUI

struct TrailerView: View {
    let request: TrailerRequest
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if let html = request.embedHTML {
                    YouTubePlayerView(html: html)
                        .ignoresSafeArea(edges: .bottom)
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "film")
                            .font(.system(size: 48))
                        Text("Trailer not available")
                            .font(.headline)
                        Text("TMDB has no trailer for this movie.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(request.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") { dismiss() }
                }
            }
        }
    }
}
