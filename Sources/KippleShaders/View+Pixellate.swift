// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(Metal)

import SwiftUI

// private struct PixellationModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .foregroundStyle(.blue)
//            .layerEffect(
//                ShaderLibrary.pixellate(
//                    .float(10)
//                ),
//                maxSampleOffset: .zero
//            )
//    }
// }

// MARK: - Extensions

public extension View {
    func pixellate(strength: Double = 4) -> some View {
        let function = ShaderFunction(
            library: .bundle(.kippleShaders),
            name: "pixellate"
        )
        let shader = Shader(function: function, arguments: [
            .float(strength),
        ])
        return self
            .layerEffect(shader, maxSampleOffset: .zero, isEnabled: true)
//            .layerEffect(
//                ShaderLibrary
//                    .bundle(.kippleShaders)
//                    .pixellate(
//                    .float(10)
//                ),
//                maxSampleOffset: .zero
//            )
    }
}

extension View {
    func aqua() -> some View {
        let function = ShaderFunction(
            library: .bundle(.kippleShaders),
            name: "aqua"
        )
        let shader = Shader(function: function, arguments: [])
        return self.colorEffect(shader, isEnabled: true)
    }
}

// MARK: - Previews

#Preview {
    Image(systemName: "photo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .pixellate()
//        .aqua()
        .padding(64)
        .background(.yellow)
}

#endif
