// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import SwiftUI

/// An indirect enum can refer to/reference itself without causing an infinite loop.
///
/// Each `NavigationNode`  includes a reference to the next node (which can either
/// be a route for navigation or an `end` node indicating that nothing more should be
/// pushed/presented).
///
/// - Note: Heavily influenced by [this excellent blog post](https://johnpatrickmorgan.github.io/2021/07/03/NStack/).
@available(watchOS 7.0, *)
indirect enum NavigationNode<Screen: Equatable, ScreenView: View>: View {
    /// Only used to indicate the start of the navigation stack.
    /// - Note: an `end` node should never manually be added to the stack!
    case end

    /// A route node indicates that there is a currently presented view as well as the conditions
    /// for pushing/presenting the next view in the stack.
    ///
    /// A `route` node specifies:
    /// - the currently visible screen,
    /// - the next node (presentation type + screen presented),
    /// - the full `NavigationRoute`s array (as a binding so that changes can be observed/propagated),
    /// - the currently visible screen's index in the routes array, and
    /// - a `ViewBuilder` block for constructing the next view.
    case route(
        NavigationRoute<Screen>,
        next: NavigationNode<Screen, ScreenView>,
        stack: Binding<[NavigationRoute<Screen>]>,
        index: Int,
        screenViewBuilder: (Screen) -> ScreenView
    )

    var body: some View {
        if case let .route(route, _, _, _, viewRouter) = self {
            viewRouter(route.screen)
                .background(self.navigationLink)
                .sheet(isPresented: isSheetPresented, onDismiss: onDismiss, content: { nextNode })
                .inNavigationView(inNavigation)
        } else {
            EmptyView()
        }
    }
    
    var navigationLink: some View {
        #if os(iOS)
        NavigationLink(isActive: isPushNavigationActive, destination: { nextNode }, label: EmptyView.init)
            .isDetailLink(false)
            .hidden()
        #else
        NavigationLink(isActive: isPushNavigationActive, destination: { nextNode }, label: EmptyView.init)
            .hidden()
        #endif
    }
}

// MARK: Private helpers

@available(watchOS 7.0, *)
private extension NavigationNode {
    var route: NavigationRoute<Screen>? {
        guard case let .route(route, _, _, _, _) = self else {
            return nil
        }
        return route
    }

    var nextNode: NavigationNode? {
        guard case let .route(_, next, _, _, _) = self else {
            return nil
        }
        return next
    }

    var isPushNavigationActive: Binding<Bool> {
        guard case .route(.push, _, _, _, _) = self.nextNode else {
            return .constant(false)
        }
        return self.isNavigationActive
    }

    var isSheetPresented: Binding<Bool> {
        guard case .route(.present, _, _, _, _) = self.nextNode else {
            return .constant(false)
        }
        return self.isNavigationActive
    }

    var onDismiss: (() -> Void)? {
        guard case let .route(.present(_, _, onDismiss), _, _, _, _) = self.nextNode else {
            return nil
        }
        return onDismiss
    }

    var inNavigation: Bool {
        self.route?.inNavigation == true
    }

    var isNavigationActive: Binding<Bool> {
        switch self {
        case .end, .route(_, next: .end, _, _, _):
            return .constant(false)
        case let .route(_, .route, stack, index, _):
            return .init {
                stack.wrappedValue.count > index + 1
            } set: { isActive in
                guard !isActive, stack.wrappedValue.count > index + 1 else { return }
                stack.wrappedValue = Array(stack.wrappedValue.prefix(index + 1))
            }
        }
    }
}

#endif
