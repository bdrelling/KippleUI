// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct KipplePicker<Content, Value>: View where Content: View, Value: Equatable, Value: Identifiable {
    @Environment(\.kipplePickerStyle) private var style

    @Binding public var selection: Value?
    public let options: [Value]

    private let content: (Value) -> Content

    public var body: some View {
        ScrollViewReader { reader in
            ScrollView(showsIndicators: false) {
                VStack(spacing: self.style.verticalSpacing) {
                    ForEach(self.options) { option in
                        KipplePickerItem(option, selection: self.$selection) {
                            self.content(option)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, self.style.horizontalSpacing / 2)
                .padding(.top)
            }
            .onAppear {
                if let selectionID = self.selection?.id {
                    reader.scrollTo(selectionID)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .withFauxNaivgationBarBackground()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(
        selection: Binding<Value?>,
        options: [Value],
        content: @escaping (Value) -> Content
    ) {
        self._selection = selection
        self.options = options
        self.content = content
    }

    /// Convenience initializer for accepting a non-optional selection.
    public init(
        selection: Binding<Value>,
        options: [Value],
        content: @escaping (Value) -> Content
    ) {
        self.init(
            selection: Binding<Value?>(
                get: {
                    selection.wrappedValue
                },
                set: { newValue in
                    if let newValue = newValue {
                        selection.wrappedValue = newValue
                    }
                }
            ),
            options: options,
            content: content
        )
    }
}

// MARK: - Supporting Types

struct KipplePickerItem<Content, Value>: View where Content: View, Value: Equatable {
    @Binding var selection: Value

    private let value: Value
    private let content: () -> Content

    private var isSelected: Bool {
        self.value == self.selection
    }

    var body: some View {
        Button(action: { self.selection = self.value }) {
            self.content()
        }
        .highlighted(self.isSelected)
    }

    init(
        _ value: Value,
        selection: Binding<Value>,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.value = value
        self._selection = selection
        self.content = content
    }
}

// MARK: - Supporting Types

private struct RefreshingView<Content>: View where Content: View {
    @Environment(\.refresh) private var refresh

    @ViewBuilder var content: (RefreshAction?) -> Content

    var body: some View {
        self.content(self.refresh)
    }
}

// MARK: - Extensions

public extension View {
    /// Enables the `KipplePicker` to refresh when loaded if options are unavailable.
    func refreshOnAppear(if condition: Bool) -> some View {
        RefreshingView { refresh in
            self.task {
                if condition {
                    await refresh?()
                }
            }
        }
    }

    /// Adds a refresh button to the toolbar.
    func withToolbarRefreshButton() -> some View {
        RefreshingView { refresh in
            self.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        role: nil,
                        action: {
                            Task { await refresh?() }
                        }
                    ) {
                        Text("??")
                    }
                }
            }
        }
    }
}

// MARK: - Previews

struct PickerView_Previews: PreviewProvider {
    enum PickerOption: String, CaseIterable, Identifiable {
        case oof
        case oofDoofa
        case ow
        case ouch
        case yikes

        var id: RawValue {
            self.rawValue
        }
    }

    static var previews: some View {
        KipplePicker(
            selection: .constant(.ow),
            options: PickerOption.allCases
        ) { option in
            Text(option.rawValue)
        }
        .previewMatrix()

        KipplePicker(
            selection: .constant(.ow),
            options: PickerOption.allCases
        ) { option in
            Text(option.rawValue)
        }
        .previewInModal()
    }
}
