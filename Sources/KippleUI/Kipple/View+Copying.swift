// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

private struct CopyingModifier: ViewModifier {
    private static let popoverVisibilityDuration: TimeInterval = 1

    @State private var isShowingPopover = false

    private let text: String
    
    #if os(iOS)
    private let backgroundColor: Color = .init(uiColor: .secondarySystemBackground)
    #elseif os(macOS)
    private let backgroundColor: Color = .init(nsColor: .windowBackgroundColor)
    #else
    #warning("backgroundColor is not defined on tvOS and watchOS!")
    private let backgroundColor: Color = .init(uiColor: .clear)
    #endif

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                // iOS doesn't have good popover functionality pre-16.4, so we build our own.
                Text("Copied!")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    .fixedSize()
                    .background(self.backgroundColor)
                    .cornerRadius(8)
                    .overlay(alignment: .bottom) {
                        Triangle()
                            .fill(self.backgroundColor)
                            .frame(width: 20, height: 10)
                            .rotationEffect(.degrees(180))
                            .offset(y: 10)
                    }
                    .offset(y: -50)
                    .opacity(self.isShowingPopover ? 1 : 0)
            }
            .onTapGesture {
                self.text.copyToClipboard()

                withAnimation(.interactiveSpring()) {
                    self.isShowingPopover = true
                }
            }
            .onChange(of: self.isShowingPopover) { _, isPresented in
                if isPresented {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Self.popoverVisibilityDuration) {
                        withAnimation(.spring()) {
                            self.isShowingPopover = false
                        }
                    }
                }
            }
    }

    init(_ text: String) {
        self.text = text
    }
}

// MARK: - Extensions

public extension View {
    /// Copies the provided text on tap.
    func copying(_ text: String) -> some View {
        modifier(CopyingModifier(text))
    }
}

// MARK: - Previews

struct ViewCopying_Previews: PreviewProvider {
    static var previews: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed interdum ipsum vitae felis tempus fringilla. Suspendisse iaculis sodales eros, ut euismod purus ultrices eget.")
            .copying("Testing")
            .padding()
    }
}
