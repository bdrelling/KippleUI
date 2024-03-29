// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

/// Modified from: https://swiftbysundell.com/articles/building-an-async-swiftui-button/
public struct AsyncButton<Label: View>: View {
    private var role: ButtonRole?
    private var action: () async throws -> Void
    private var options: Set<AsyncButtonOption>
    @ViewBuilder private var label: () -> Label

    @State private var isDisabled = false
    @State private var showProgressView = false

    public var body: some View {
        Button(
            role: self.role,
            action: {
                if self.options.contains(.disableButton) {
                    self.isDisabled = true
                }

                Task {
                    var progressViewTask: Task<Void, Error>?

                    if self.options.contains(.showProgressView) {
                        progressViewTask = Task {
                            try await Task.sleep(nanoseconds: 150000000)
                            self.showProgressView = true
                        }
                    }

                    // TODO: Handle error?
                    try await self.action()
                    progressViewTask?.cancel()

                    self.isDisabled = false
                    self.showProgressView = false
                }
            },
            label: {
                ZStack {
                    self.label().opacity(self.showProgressView ? 0 : 1)

                    if self.showProgressView {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(self.isDisabled)
    }

    public init(
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void,
        options: Set<AsyncButtonOption> = .allCases,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.role = role
        self.action = action
        self.options = options
        self.label = label
    }
}

// MARK: - Supporting Types

public enum AsyncButtonOption: CaseIterable {
    case disableButton
    case showProgressView
}

// MARK: - Extensions

public extension AsyncButton where Label == Text {
    init(
        _ title: String,
        role: ButtonRole? = nil,
        options _: Set<AsyncButtonOption> = .allCases,
        action: @escaping () async throws -> Void
    ) {
        self.init(role: role, action: action) {
            Text(title)
        }
    }
}

public extension AsyncButton where Label == Image {
    init(
        systemImageName: String,
        role: ButtonRole? = nil,
        options _: Set<AsyncButtonOption> = .allCases,
        action: @escaping () async throws -> Void
    ) {
        self.init(role: role, action: action) {
            Image(systemName: systemImageName)
        }
    }
}

public extension Set where Element == AsyncButtonOption {
    static var allCases: Self {
        .init(Element.allCases)
    }
}
