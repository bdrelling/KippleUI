// Copyright © 2023 Brian Drelling. All rights reserved.

#if os(iOS)

import SwiftUI

// source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
public struct DeviceRotationViewModifier: ViewModifier {
    private let action: (UIDeviceOrientation) -> Void

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                self.action(UIDevice.current.orientation)
            }
    }

    init(action: @escaping (UIDeviceOrientation) -> Void) {
        self.action = action
    }
}

// MARK: - Extensions

public extension View {
    func onDeviceRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

#endif
