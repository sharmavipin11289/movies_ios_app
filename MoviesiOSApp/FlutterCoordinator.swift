//
//  FlutterCoordinator.swift
//  MoviesiOSApp
//
//  Created by Vipin Sharma on 25/10/26.
//

import Combine
import Flutter
import SwiftUI


final class FlutterCoordinator: ObservableObject {
    // Must be identical to NativeBridge.channelName in the Flutter module.
    static let channelName = "com.vipin.movies/bridge"

    /// Set when Flutter asks for a trailer; the UI shows the trailer screen.
    @Published var trailer: TrailerRequest?

    private let engine = FlutterEngine(name: "movies_engine")
    private var channel: FlutterMethodChannel?
    private weak var flutterViewController: FlutterViewController?

    init() {
        engine.run()  // runs the module's main()

        let channel = FlutterMethodChannel(
            name: Self.channelName,
            binaryMessenger: engine.binaryMessenger
        )
        channel.setMethodCallHandler { [weak self] call, result in
            self?.handle(call, result: result)
        }
        self.channel = channel
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

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard call.method == "openTrailer" else {
            result(FlutterMethodNotImplemented)
            return
        }
        guard let request = TrailerRequest(arguments: call.arguments) else {
            result(FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "openTrailer needs movieId and title",
                details: nil
            ))
            return
        }
        result(nil)
        show(request)
    }

    /// Closes Flutter first, then shows the native trailer screen.
    private func show(_ request: TrailerRequest) {
        guard let controller = flutterViewController else {
            trailer = request
            return
        }
        controller.dismiss(animated: true) { [weak self] in
            self?.trailer = request
        }
    }

    private static func rootViewController() -> UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }?
            .windows.first { $0.isKeyWindow }?
            .rootViewController
    }
}
