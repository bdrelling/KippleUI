// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

#if os(macOS)

    public typealias SafeNavigationView = MacOSNavigationView

    // TODO: @Environment and @EnvironmentObject is not yet supported.
    //       Workaround: Move Environment explicitly to the Destination, instead of the Button.
    public struct MacOSNavigationView<Content>: View where Content: View {
        @StateObject private var navigator: Navigator

        public var body: some View {
            VStack {
                if self.navigator.isAnimating {
                    self.navigator.previousView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.navigating(self.navigator.navigationDirection.opposite))
                } else {
                    self.navigator.activeView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.navigating(self.navigator.navigationDirection))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    // This is a hack to make macOS create space for the toolbar.
                    // Without this, the min/max/close buttons "jump" into position
                    // after the first element in this group appears.
                    Text("").hidden()

                    if self.navigator.shouldShowBackButton {
                        Button(action: { self.navigator.navigateBack() }) {
                            Image(systemName: "chevron.backward")
                        }
                        .disabled(self.navigator.isAnimating)
                    }
                }
            }
            .environmentObject(self.navigator)
        }

        public init(@ViewBuilder content: @escaping () -> Content) {
            let navigator = Navigator(AnyView(content()))
            self._navigator = .init(wrappedValue: navigator)
        }
    }

#else

    public typealias SafeNavigationView = NavigationView

#endif
