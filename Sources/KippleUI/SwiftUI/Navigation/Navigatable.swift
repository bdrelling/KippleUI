// Copyright © 2022 Brian Drelling. All rights reserved.

/// This protocol defines a `Screen` type and a stack manager that expects the same type.
///
/// Types that need to read/update the current navigation stack (specifically view models
/// associated with screens in the stack) should conform to this protocol.
public protocol Navigatable {
    associatedtype Screen: Equatable
    var navigationManager: NavigationStackManager<Screen> { get set }
}

public extension Navigatable {
    func push(_ screen: Screen) {
        navigationManager.push(screen)
    }

    func present(_ screen: Screen, inNavigation: Bool = true, onDismiss: (() -> Void)? = nil) {
        navigationManager.present(screen, inNavigation: inNavigation, onDismiss: onDismiss)
    }

    func pop() {
        navigationManager.pop()
    }

    func popTo(_ screen: Screen) {
        navigationManager.popTo(screen)
    }

    func popToRoot() {
        navigationManager.popToRoot()
    }

    func dismiss() {
        navigationManager.dismiss()
    }

    func switchRoot(to screen: Screen) {
        navigationManager.updateRoot(screen)
    }

    func goBack() {
        navigationManager.goBack()
    }
}
