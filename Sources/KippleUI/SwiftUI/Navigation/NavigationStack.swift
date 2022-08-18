// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

/// A full view hierarchy representing an array of `NavigationRoute` instances, where each instance
/// includes the `Screen` instance to be presented and its presentation method — e.g., via navigation
/// link (push) or sheet.
///
/// - Note: Heavily influenced by [this excellent blog post](https://johnpatrickmorgan.github.io/2021/07/03/NStack/).
public struct NavigationStack<Screen: Equatable, ScreenView: View>: View {
    /// The routes representing the current state of the view hierarchy managed by this `NavigationState`, from
    /// the root view (`navigationRoutes.first`) to the currently visible view (`navigationRoutes.last`).
    @Binding var navigationRoutes: [NavigationRoute<Screen>]

    /// This view builder block represents the router for the current navigation stack, i.e., a factory that takes any
    /// `Screen` instance and constructs the associated `ScreenView`.
    @ViewBuilder var screenViewBuilder: (Screen) -> ScreenView

    public var body: some View {
        navigationRoutes
            // enumerate the stack to get the element and its index
            .enumerated()
            // reverse the stack to ensure indices don't change
            .reversed()
            // reduce the stack into a single view hierarchy
            .reduce(NavigationNode<Screen, ScreenView>.end) { nextNode, new in
                .route(
                    new.element,
                    next: nextNode,
                    stack: $navigationRoutes,
                    index: new.offset,
                    screenViewBuilder: screenViewBuilder
                )
            }
    }

    /// Initializes a full view hierarchy given an array of `Screen`s (screen + presentation type)
    /// and a `@ViewBuilder` block.
    ///
    /// - parameter navigationRoutes: binding to an array of `NavigationRoute`s
    /// - parameter screenViewBuilder: builds a `ScreenView` from a given `Screen`
    public init(
        _ navigationRoutes: Binding<[NavigationRoute<Screen>]>,
        @ViewBuilder screenViewBuilder: @escaping (Screen) -> ScreenView
    ) {
        _navigationRoutes = navigationRoutes
        self.screenViewBuilder = screenViewBuilder
    }
}

#endif
