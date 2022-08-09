// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public struct PreviewMatrix: ViewModifier {
    public let layouts: [Layout]
    public let colorSchemes: [ColorScheme]

    init(layouts: [Layout], colorSchemes: [ColorScheme]? = nil) {
        self.layouts = layouts
        self.colorSchemes = colorSchemes ?? ColorScheme.allCases
    }

    public func body(content: Content) -> some View {
        ForEach(self.layouts, id: \.id) { layout in
            // In Xcode 14+, you can see various color schemes for a given view in the canvas.
            #if swift(>=5.7)
            content
                // Set up the preview configuration
                .previewLayout(layout.previewLayout)
                .previewDevice(layout.previewDevice)
                .previewDisplayName(layout.name)
            #else
            ForEach(colorSchemes, id: \.self) { colorScheme in
                content
                    // Set up the preview configuration
                    .previewLayout(layout.previewLayout)
                    .previewDevice(layout.previewDevice)
                    .previewDisplayName("\(layout.name) (\(colorScheme.name))")
                    // Apply color schemes to the modified preview
                    .preferredColorScheme(colorScheme)
            }
            #endif
        }
    }
}

// MARK: - ViewModifier Extensions

public extension View {
    func previewMatrix(_ matrix: PreviewMatrix = .default) -> some View {
        self.modifier(matrix)
    }

    func previewMatrix(_ layouts: PreviewMatrix.Layout..., colorSchemes: [ColorScheme]? = nil) -> some View {
        self.previewMatrix(.init(layouts: layouts, colorSchemes: colorSchemes))
    }

    func previewMatrix(_ type: PreviewDeviceType) -> some View {
        self.previewMatrix(.init(layouts: .device(type)))
    }
}

// MARK: - Previews

struct PreviewMatrix_Previews: PreviewProvider {
    static var previews: some View {
        Text("Testing!")
            .previewMatrix(
                .currentDevice,
                .device(.iPodTouchGen7),
                .fixedSize(width: 200, height: 80),
                .sizeThatFits
            )
    }
}
