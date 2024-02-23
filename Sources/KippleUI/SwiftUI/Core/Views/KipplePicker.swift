// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct KipplePicker<Content, Value>: View where Content: View, Value: Equatable, Value: Identifiable {
    @Environment(\.kipplePickerStyle) private var style

    @Binding public var selection: Value?
    public let options: [Value]

    private let content: (Value) -> Content

    public var body: some View {
        Group {
            if self.options.isEmpty {
                self.emptyLabel
            } else {
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
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyLabel: some View {
        Text("No options available")
            .opacity(0.35)
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
