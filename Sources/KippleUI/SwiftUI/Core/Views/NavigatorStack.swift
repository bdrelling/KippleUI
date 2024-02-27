// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
public struct NavigatorStack<Content>: View where Content: View {
    @Bindable private var navigator: Navigator
    private let content: (Navigator) -> Content

    public var body: some View {
        NavigationStack(path: self.$navigator.path) {
            self.content(self.navigator)
        }
        .environment(\.navigator, self.navigator)
    }

    public init(
        navigator: Navigator,
        @ViewBuilder content: @escaping (Navigator) -> Content
    ) {
        _navigator = .init(wrappedValue: navigator)
        self.content = content
    }

    public init(
        navigator: Navigator,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(navigator: navigator, content: { _ in content() })
    }

    public init(
        path: NavigationPath = .init(),
        @ViewBuilder content: @escaping (Navigator) -> Content
    ) {
        self.init(navigator: .init(path: path), content: content)
    }

    public init(
        path: NavigationPath = .init(),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(navigator: .init(path: path), content: content)
    }
}

// MARK: - Supporting Types

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
@Observable
public final class Navigator {
    public var path: NavigationPath

    public init(path: NavigationPath = .init()) {
        self.path = path
    }

    /// Pushes the provided value onto the navigation path.
    public func push<PathComponent>(_ component: PathComponent) where PathComponent: Hashable {
        self.path.append(component)
    }

    /// Pops the current view off the navigation stack.
    /// - Parameter count: The number of views to pop off the stack. If this value is greater than the total number of views in the stack, this method will do nothing.
    public func pop(_ count: Int = 1) {
        // If we're popping an item off of the path, the path should not be empty.
        guard !self.path.isEmpty, self.path.count >= count else { return }
        self.path.removeLast(count)
    }

    /// Resets the `path` to return to its root view.
    public func popToRoot() {
        self.path = .init()
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
private struct NavigatorKey: EnvironmentKey {
    static let defaultValue: Navigator = .init()
}

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
public extension EnvironmentValues {
    var navigator: Navigator {
        get { self[NavigatorKey.self] }
        set { self[NavigatorKey.self] = newValue }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
public protocol Navigable: Hashable {
    associatedtype View: SwiftUI.View
    @ViewBuilder var view: View { get }
}

// MARK: - Extensions

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
public extension Navigator {
    convenience init<PathComponent>(path: [PathComponent]) where PathComponent: Hashable {
        self.init(path: .init(path))
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 14.0, watchOS 10.0, *)
public extension View {
    func navigationDestination<N>(for _: N.Type) -> some View where N: Navigable {
        self.navigationDestination(for: N.self) { $0.view }
    }
}
