//
//  TrailerRequest.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import Foundation

struct TrailerRequest: Identifiable, Equatable {
    let movieId: Int
    let title: String
    /// YouTube video key, nil when TMDB has no trailer.
    let youtubeKey: String?

    var id: Int { movieId }

    init(movieId: Int, title: String, youtubeKey: String?) {
        self.movieId = movieId
        self.title = title
        if let youtubeKey, !youtubeKey.isEmpty {
            self.youtubeKey = youtubeKey
        } else {
            self.youtubeKey = nil
        }
    }

    /// Builds a request from the MethodChannel arguments, or nil if invalid.
    init?(arguments: Any?) {
        guard let map = arguments as? [String: Any],
              let movieId = map["movieId"] as? Int,
              let title = map["title"] as? String else { return nil }
        self.init(
            movieId: movieId,
            title: title,
            youtubeKey: map["youtubeKey"] as? String
        )
    }

    /// Full HTML page with the YouTube player, or nil when there is no trailer.
    var embedHTML: String? {
        guard let youtubeKey else { return nil }
        return """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          html, body { margin: 0; height: 100%; background: #000; }
          iframe { position: absolute; inset: 0; width: 100%; height: 100%; border: 0; }
        </style>
        </head>
        <body>
        <iframe
          src="https://www.youtube.com/embed/\(youtubeKey)?playsinline=1&autoplay=1&rel=0"
          allow="autoplay; encrypted-media; picture-in-picture"
          allowfullscreen></iframe>
        </body>
        </html>
        """
    }
}
