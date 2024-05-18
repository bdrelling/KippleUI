// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleFoundation
import SwiftUI

private struct AlertHandlerModifier: ViewModifier {
    @Bindable var alertHandler: AlertHandler

    private let isDebugging: Bool

    func body(content: Content) -> some View {
        content
            .environment(\.alertHandler, self.alertHandler)
            .alert(
                "Error",
                isPresented: self.$alertHandler.isErrorPresented,
                presenting: self.alertHandler.error,
                actions: { _ in
                    Button("Ok") {}
                },
                message: { error in
                    if self.isDebugging {
                        Text("\(error.message)\n\n\(error.source)")
                    } else {
                        Text(error.message)
                    }
                }
            )
    }

    init(alertHandler: AlertHandler, isDebugging: Bool) {
        self.alertHandler = alertHandler
        self.isDebugging = isDebugging
    }
}

// MARK: - Supporting Types

@Observable
public final class AlertHandler {
    public private(set) var error: AlertHandlerError?
    public var isErrorPresented: Bool = false

    public func `catch`(_ error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.error = .init(
            message: error.localizedDescription,
            file: "\(file)",
            function: "\(function)",
            line: line
        )

        self.isErrorPresented = true
    }

    public func `catch`(_ body: @escaping () throws -> Void, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        do {
            try body()
        } catch {
            self.catch(error, file: file, function: function, line: line)
        }
    }

    public func `catch`(_ body: @escaping () async throws -> Void, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Task { @MainActor [weak self] in
            guard let self else { return }

            await self.catch(body, file: file, function: function, line: line)
        }
    }

    @MainActor
    public func `catch`(_ body: @escaping () async throws -> Void, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) async {
        do {
            try await body()
        } catch {
            self.catch(error, file: file, function: function, line: line)
        }
    }
}

private struct AlertHandlerKey: EnvironmentKey {
    static let defaultValue: AlertHandler = .init()
}

public extension EnvironmentValues {
    var alertHandler: AlertHandler {
        get { self[AlertHandlerKey.self] }
        set { self[AlertHandlerKey.self] = newValue }
    }
}

public struct AlertHandlerError: Sendable, Equatable, Hashable {
    public let message: String
    public let file: String
    public let function: String
    public let line: UInt

    public var filename: String {
        self.file.split(separator: "/").last?.replacingOccurrences(of: ".swift", with: "") ?? self.file
    }

    public var source: String {
        "\(self.filename).\(self.function):\(self.line)"
    }
}

// MARK: - Extensions

public extension View {
    func handleAlerts(with alertHandler: AlertHandler? = nil, isDebugging: Bool = .isDebugging) -> some View {
        self.modifier(AlertHandlerModifier(alertHandler: alertHandler ?? .init(), isDebugging: isDebugging))
    }
}

extension AlertHandlerError: LocalizedError {
    public var errorDescription: String? {
        self.message
    }
}
