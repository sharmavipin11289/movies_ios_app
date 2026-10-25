//
//  FlutterCoordinator.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import Combine
import Flutter
import FlutterPluginRegistrant
import SwiftUI

/// Owns the Flutter engine and presents the Flutter module.
final class FlutterCoordinator: ObservableObject {
    private let engine = FlutterEngine(name: "movies_engine")
    private weak var flutterViewController: FlutterViewController?

    init() {
        engine.run()  // runs the module's main()
        GeneratedPluginRegistrant.register(with: engine)
    }

    func showFlutter() {
        guard flutterViewController == nil,
              let presenter = Self.rootViewController() else { return }
        let controller = FlutterViewController(
            engine: engine, nibName: nil, bundle: nil
        )
        controller.modalPresentationStyle = .fullScreen
        flutterViewController = controller
        presenter.present(controller, animated: true)
    }

    private static func rootViewController() -> UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }?
            .windows.first { $0.isKeyWindow }?
            .rootViewController
    }
}
