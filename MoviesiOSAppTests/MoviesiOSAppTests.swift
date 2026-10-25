//
//  MoviesiOSAppTests.swift
//  MoviesiOSAppTests
//
//  Created by Vipin Sharma on 25/10/26.
//

import XCTest
@testable import MoviesiOSApp

final class TrailerRequestTests: XCTestCase {

    func test_init_parsesAllArguments() {
        let request = TrailerRequest(arguments: [
            "movieId": 550,
            "title": "Fight Club",
            "youtubeKey": "abc123",
        ])

        XCTAssertEqual(request?.movieId, 550)
        XCTAssertEqual(request?.title, "Fight Club")
        XCTAssertEqual(request?.youtubeKey, "abc123")
    }

    func test_init_keepsKeyNilWhenFlutterSendsNull() {
        let request = TrailerRequest(arguments: [
            "movieId": 1,
            "title": "No Trailer",
            "youtubeKey": NSNull(),
        ])

        XCTAssertNotNil(request)
        XCTAssertNil(request?.youtubeKey)
    }

    func test_init_treatsEmptyKeyAsNil() {
        let request = TrailerRequest(arguments: [
            "movieId": 1,
            "title": "t",
            "youtubeKey": "",
        ])

        XCTAssertNil(request?.youtubeKey)
    }

    func test_init_returnsNilWhenMovieIdIsMissing() {
        XCTAssertNil(TrailerRequest(arguments: ["title": "t"]))
    }

    func test_init_returnsNilWhenArgumentsAreNotAMap() {
        XCTAssertNil(TrailerRequest(arguments: "oops"))
        XCTAssertNil(TrailerRequest(arguments: nil))
    }

    func test_embedHTML_containsTheYouTubeEmbedUrl() {
        let request = TrailerRequest(movieId: 1, title: "t", youtubeKey: "abc123")

        XCTAssertTrue(
            request.embedHTML?.contains("youtube.com/embed/abc123") ?? false
        )
    }

    func test_embedHTML_isNilWithoutKey() {
        let request = TrailerRequest(movieId: 1, title: "t", youtubeKey: nil)

        XCTAssertNil(request.embedHTML)
    }
}
