// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct AlertHandlerModifier: ViewModifier {
    @Bindable var alertHandler: AlertHandler

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
                    Text(error.localizedDescription)
                }
            )
    }

    init(alertHandler: AlertHandler) {
        self.alertHandler = alertHandler
    }
}

// MARK: - Supporting Types

@Observable
public final class AlertHandler {
    public private(set) var error: Error?
    public var isErrorPresented: Bool = false

    public func `catch`(_ error: Error) {
        self.error = error
        self.isErrorPresented = true
    }

    public func `catch`(_ body: @escaping () throws -> Void) {
        do {
            try body()
        } catch {
            self.catch(error)
        }
    }

    public func `catch`(_ body: @escaping () async throws -> Void) {
        Task { @MainActor [weak self] in
            guard let self else { return }

            await self.catch(body)
        }
    }

    @MainActor
    public func `catch`(_ body: @escaping () async throws -> Void) async {
        do {
            try await body()
        } catch {
            self.catch(error)
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

// MARK: - Extensions

public extension View {
    func handleAlerts(with alertHandler: AlertHandler? = nil) -> some View {
        self.modifier(AlertHandlerModifier(alertHandler: alertHandler ?? .init()))
    }
}
