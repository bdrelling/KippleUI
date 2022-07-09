// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

#if os(macOS)

    public typealias SafeNavigationLink = MacOSNavigationLink

    public struct MacOSNavigationLink<Label, Destination>: View where Label: View, Destination: View {
        @Binding private var isActive: Bool
        @ViewBuilder private var destination: () -> Destination
        @ViewBuilder private var label: () -> Label

        @State private var navigationIndex: Int?

        @EnvironmentObject private var navigator: Navigator

        public var body: some View {
            Button(action: self.navigate, label: self.label)
                .onAppear {
                    self.navigationIndex = self.navigator.nextNavigationIndex

                    if self.isActive {
                        self.navigator.push(self.destination())
                    }
                }
            // TODO: Implement support for isActive: Binding<Bool> and Hashable selections.
            // .onChange(of: self.isActive) { isActive in
            //     if isActive {
            //         // TODO: Animate this one onto the stack, then remove previous views that were not applicable.
            //         self.navigate()
            //     } else {
            //         // TODO: Navigate all the way back to the view before this one.
            //         self.navigator.navigateBack()
            //     }
            // }
        }

        // TODO: Implement support for isActive: Binding<Bool> and Hashable selections.
        private init(isActive: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
            self._isActive = isActive
            self.destination = destination
            self.label = label
        }

        public init(@ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
            self.init(
                isActive: .constant(false),
                destination: destination,
                label: label
            )
        }

        // TODO: Implement support for isActive: Binding<Bool> and Hashable selections.
        private init(isActive: Binding<Bool>, destination: Destination, @ViewBuilder label: @escaping () -> Label) {
            self.init(isActive: isActive, destination: { destination }, label: label)
        }

        public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
            self.init(destination: { destination }, label: label)
        }

        private func navigate() {
            self.navigator.navigate(to: self.destination, atIndex: self.navigationIndex)
        }
    }

#else

    public typealias SafeNavigationLink = NavigationLink

#endif
