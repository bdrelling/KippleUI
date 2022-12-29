// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct BackButton<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    public let content: () -> Content

    public var body: some View {
        Button(action: self.dismiss) {
            self.content()
        }
    }

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Supporting Types

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public struct BackButtonPreviewer<Content>: View where Content: View {
    @State private var path: [Int] = [1]

    public let content: () -> Content

    public var body: some View {
        NavigationStack(path: $path) {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    NavigationLink(value: 1, label: { Text("Preview") })
                }
                .navigationDestination(for: Int.self) { _ in
                    self.content()
                }
        }
    }

    public init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public extension View {
    func withBackButton<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        Group {
            if #unavailable(iOS 14, macOS 11, tvOS 14, watchOS 7) {
                self
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: content())
            } else {
                self
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            BackButton(content: content)
                        }
                    }
            }
        }
    }
}

// MARK: - Previews

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonPreviewer {
            Color.blue
                .edgesIgnoringSafeArea(.all)
                .withBackButton {
                    Text("go bak")
                        .padding()
                        .background(Color.purple)
                }
        }
        .preferredColorScheme(.dark)
    }
}
