// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

public struct PreviewMatrix: ViewModifier {
    public let layouts: [Layout]

    public init(layouts: [Layout]) {
        self.layouts = layouts
    }

    public func body(content: Content) -> some View {
        ForEach(self.layouts, id: \.id) { layout in
            content
                // Set up the preview configuration
                .previewLayout(layout.previewLayout)
                .previewDevice(layout.previewDevice)
                .previewDisplayName(layout.name)
        }
    }
}

// MARK: - ViewModifier Extensions

public extension View {
    func previewMatrix(_ matrix: PreviewMatrix = .default) -> some View {
        modifier(matrix)
    }

    func previewDevice(_ type: PreviewDeviceType) -> some View {
        self.previewMatrix(.init(layouts: .device(type)))
    }

    func previewLayouts(_ layouts: [PreviewMatrix.Layout]) -> some View {
        self.previewMatrix(.init(layouts: layouts))
    }

    func previewLayouts(_ layouts: PreviewMatrix.Layout...) -> some View {
        self.previewLayouts(layouts)
    }

    @available(macOS 11.0, *)
    func previewLayouts(_ layouts: [PreviewMatrix.Layout], colorSchemes: [ColorScheme]) -> some View {
        self.previewLayouts(layouts)
            .previewColorSchemes(colorSchemes)
    }

    @available(macOS 11.0, *)
    func previewLayouts(_ layouts: PreviewMatrix.Layout..., colorSchemes: [ColorScheme]) -> some View {
        self.previewLayouts(layouts, colorSchemes: colorSchemes)
    }

    @available(macOS 11.0, *)
    func previewColorSchemes(_ colorSchemes: [ColorScheme]) -> some View {
        ForEach(colorSchemes, id: \.self) { colorScheme in
            self.preferredColorScheme(colorScheme)
        }
    }
}

// MARK: - Previews

struct PreviewMatrix_Previews: PreviewProvider {
    static var previews: some View {
        Text("Testing!")
            .previewLayouts(
                .currentDevice,
                .device(.iPodTouchGen7),
                .fixedSize(width: 200, height: 80),
                .sizeThatFits
            )
    }
}
