// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

/// A convenience class for observing and managing the data model for a navigation stack
/// (that is, an array of `NavigationRoute`s).
public class NavigationStackManager<Screen: Equatable>: ObservableObject {
    /// The current view hierarchy's data model.
    @Published public var stack: [NavigationRoute<Screen>] = []

    /// Initializes a new observable data model for a navigation stack with its root screen visible.
    ///
    /// - parameter rootScreen: the root screen of the current stack/view hierarchy.
    public convenience init(withRoot rootScreen: Screen) {
        self.init(stack: [.root(rootScreen)])
    }

    /// Initializes a new observable data model for a navigation stack.
    ///
    /// - parameter stack: an array of routes representing the desired view hierarchy of
    /// the current navigation stack. The `root` route **must be the first element** in the array.
    ///
    /// - Note: Unless you need an empty/mock stack or need to lay out several views in a view hierarchy
    /// (e.g., for deep linking), always prefer the convenience initializer `init(withRoot:)`, as it takes care
    /// of configuring + positioning the root route.
    public init(stack: [NavigationRoute<Screen>]) {
        self.stack = stack
    }

    /// Pushes the provided screen onto the stack via `NavigationLink`.
    public func push(_ screen: Screen) {
        self.stack.append(.push(screen))
    }

    /// Presents the view associated with the provided screen in a sheet.
    ///
    /// - Note: The presented view is embedded in a `NavigationView` by default unless specified.
    public func present(_ screen: Screen, inNavigation: Bool = true, onDismiss: (() -> Void)? = nil) {
        self.stack.append(.present(screen, inNavigation: inNavigation, onDismiss: onDismiss))
    }

    /// Pops the last view off the stack (if currently pushed).
    public func pop() {
        guard self.stack.last?.isPresented == false else { return }
        self.goBack(by: 1)
    }

    /// If the passed-in screen is currently in the stack, pop/dismiss any subsequent screens in the array
    /// until the specified screen's view is visible.
    public func popTo(_ screen: Screen) {
        guard let index = Array(stack.reversed()).firstIndex(where: { $0.screen == screen }) else { return }
        self.goBack(by: index)
    }

    /// Removes all routes from the stack/all views from the navigation stack except the root.
    ///
    /// - parameter refresh: if `true` the root route is reconstructed; if `false`
    /// the existing root screen is displayed as-is. (Defaults to `false`.)
    public func popToRoot(andRefresh refresh: Bool = false) {
        if refresh, let first = stack.first {
            self.updateRoot(first.screen)
        } else {
            self.goBack(by: self.stack.count - 1)
        }
    }

    /// Dismisses the last view from the stack (if currently presented).
    public func dismiss() {
        guard self.stack.last?.isPresented == true else { return }
        self.goBack(by: 1)
    }

    /// Pops or dismisses the top view, depending on its presentation state.
    /// - Note: If the stack is empty or the top route is a `root`, nothing happens.
    public func goBack() {
        guard self.stack.count > 1 else { return }
        switch self.stack.last {
        case .present: self.dismiss()
        case .push: self.pop()
        default: return
        }
    }

    /// Removes all current screens from the stack and sets the specified root screen.
    public func updateRoot(_ screen: Screen) {
        self.stack = [.root(screen)]
    }

    private func goBack(by numberOfScreens: Int) {
        guard self.stack.count > numberOfScreens else { return }
        self.stack = self.stack.dropLast(numberOfScreens)
    }
}
