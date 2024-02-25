// Copyright © 2024 Brian Drelling. All rights reserved.

//// Copyright © 2024 Brian Drelling. All rights reserved.
//
// import SwiftUI
//
// private struct BlendModePreviewer: ViewModifier {
//    let columns: Int
//    let spacing: CGFloat
//
//    func body(content: Content) -> some View {
//        ScrollView {
//            LazyVGrid(
//                columns: self.columns,
//                spacing: self.spacing,
//                horizontalSpacing: self.spacing
//            ) {
//                ForEach(BlendMode.allCases, id: \.self) { blendMode in
//                    VStack {
//                        content
//                            .blendMode(blendMode)
//                        Text(String(describing: blendMode))
//                    }
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//    }
// }
//
//// MARK: - Extensions
//
// extension BlendMode: CaseIterable {
//    public static var allCases: [BlendMode] {
//        [
//            .normal,
//            .multiply,
//            .screen,
//            .overlay,
//            .darken,
//            .lighten,
//            .colorDodge,
//            .colorBurn,
//            .softLight,
//            .hardLight,
//            .difference,
//            .exclusion,
//            .hue,
//            .saturation,
//            .color,
//            .luminosity,
//            .sourceAtop,
//            .destinationOver,
//            .destinationOut,
//            .plusDarker,
//            .plusLighter,
//        ]
//    }
// }
//
// public extension View {
//    func previewBlendModes(
//        _ blendModes: [BlendMode] = BlendMode.allCases,
//        columns: Int = 2,
//        spacing: CGFloat = 16
//    ) -> some View {
//        self.modifier(BlendModePreviewer(columns: columns, spacing: spacing))
//    }
// }
