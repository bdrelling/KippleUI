// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public final class Navigator: ObservableObject {
    @Published private var navigationStack: [AnyView] = []

    public var isAnimating: Bool = false
    public var navigationDirection: NavigationDirection = .forward

    public var activeView: AnyView {
        self.navigationStack.last!
    }

    public var previousView: AnyView? {
        if self.navigationStack.count >= 2 {
            return self.navigationStack.reversed()[1]
        } else {
            return nil
        }
    }

    public var nextNavigationIndex: Int {
        self.navigationStack.count
    }

    public var shouldShowBackButton: Bool {
        self.navigationStack.count > 1
    }

    public init(_ rootView: AnyView) {
        self.navigationStack.append(rootView)
    }

    public func push<V: View>(_ view: V) {
        self.navigationStack.append(AnyView(view))
    }

    public func pop() {
        _ = self.navigationStack.popLast()
    }

    public func navigate<V: View>(to view: V, atIndex index: Int? = nil) {
        self.isAnimating = true

        withAnimation(.default) {
            self.push(view)
            self.isAnimating = false
        }
    }

    public func navigate<V: View>(@ViewBuilder to view: @escaping () -> V, atIndex index: Int? = nil) {
        self.navigate(to: view())
    }

    public func navigateBack() {
        self.navigationDirection = .back
        self.isAnimating = true

        withAnimation(.default) {
            self.pop()
            self.isAnimating = false

            // In order to ensure the navigationDirection isn't reset at the beginning of the animation,
            // we need to put the navigation direction change into an async dispatch block.
            DispatchQueue.main.async {
                self.navigationDirection = .forward
            }
        }
    }
}
