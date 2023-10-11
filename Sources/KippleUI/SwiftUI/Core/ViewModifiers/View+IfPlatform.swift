// Copyright © 2023 Brian Drelling. All rights reserved.

import SwiftUI

public enum Platform {
    case macOS
    case iOS
    case tvOS
    case watchOS
    case visionOS

    #if os(macOS)
    static let current = macOS
    #elseif os(iOS)
    static let current = iOS
    #elseif os(tvOS)
    static let current = tvOS
    #elseif os(watchOS)
    static let current = watchOS
    #elseif os(visionOS)
    static let current = visionOS
    #else
    #error("Unsupported platform")
    #endif
}

// source: https://stackoverflow.com/a/62099616
public extension View {
    /**
     Conditionally apply modifiers depending on the target operating system.

     ```
     struct ContentView: View {
         var body: some View {
             Text("Unicorn")
                 .font(.system(size: 10))
                 .ifOS(.macOS, .tvOS) {
                     $0.font(.system(size: 20))
                 }
         }
     }
     ```
     */
    @ViewBuilder
    func ifPlatform<Content: View>(
        _ operatingSystems: Platform...,
        modifier: (Self) -> Content
    ) -> some View {
        if operatingSystems.contains(Platform.current) {
            modifier(self)
        } else {
            self
        }
    }
}
