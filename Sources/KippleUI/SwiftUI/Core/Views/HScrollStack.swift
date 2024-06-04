// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct HScrollStack<ID, Content>: View where Content: View, ID: Hashable {
    @Binding private var selection: ID
    private let spacing: CGFloat

    @ViewBuilder private let content: () -> Content

    public var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                // NOTE: scrollPosition modifier below only works with LazyHStack (not HStack) as of iOS 17.4
                LazyHStack(spacing: self.spacing) {
                    self.content()
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(
                id: .init(
                    get: { self.selection },
                    set: { newValue in
                        if let newValue {
                            self.selection = newValue
                        }
                    }
                ),
                anchor: .center
            )
            .task {
                // This is a task and NOT onAppear because we need a slight delay for this to trigger and start in the right position
                reader.scrollTo(self.selection, anchor: .center)
            }
        }
    }

    public init(selection: Binding<ID>, spacing: CGFloat = 0, @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.spacing = spacing
        self.content = content
    }
}

// MARK: - Previews

private struct Preview: View {
    @State var selection: Color

    private let colors: [Color] = [
        .red,
        .orange,
        .yellow,
        .blue,
        .green,
        .indigo,
    ]

    var body: some View {
        VStack {
            Text("\(String(describing: self.selection))")

            GeometryReader { geometry in
                HScrollStack(selection: self.$selection) {
                    ForEach(self.colors, id: \.self) { color in
                        color
                            .frame(width: geometry.size.width)
                    }
                }
            }
        }
    }
}

#Preview {
    Preview(selection: .blue)
}
