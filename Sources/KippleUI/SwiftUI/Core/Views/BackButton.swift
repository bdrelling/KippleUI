// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct BackButton<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    private let content: () -> Content
    private let visibility: Visibility

    private var isVisible: Bool {
        switch self.visibility {
        case .visible:
            return true
        case .hidden:
            return false
        case .automatic:
            return self.presentationMode.wrappedValue.isPresented
        }
    }

    public var body: some View {
        if self.isVisible {
            Button(action: self.dismiss) {
                self.content()
            }
        } else {
            EmptyView()
        }
    }

    public init(visibility: Visibility = .automatic, @ViewBuilder content: @escaping () -> Content) {
        self.visibility = visibility
        self.content = content
    }

    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Supporting Types

public struct BackButtonPreviewer<Content>: View where Content: View {
    @State private var path: [Int] = [1]

    public let content: () -> Content

    public var body: some View {
        NavigationStack(path: self.$path) {
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

@available(watchOS, unavailable)
public extension View {
    func withBackButton<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar {
                #if os(macOS)
                ToolbarItem(placement: .principal) {
                    BackButton(content: content)
                }
                #else
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(content: content)
                }
                #endif
            }
    }
}

// MARK: - Previews

@available(watchOS, unavailable)
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
