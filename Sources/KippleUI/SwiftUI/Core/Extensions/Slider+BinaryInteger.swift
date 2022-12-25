// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension Slider {
    init<V>(
        value: Binding<V>,
        in bounds: ClosedRange<V>,
        step: V.Stride = 1,
        @ViewBuilder label: () -> Label,
        @ViewBuilder minimumValueLabel: () -> ValueLabel,
        @ViewBuilder maximumValueLabel: () -> ValueLabel,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) where V: BinaryInteger, V.Stride: BinaryInteger {
        self.init(
            value: .init(get: { Float(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
            in: Float(bounds.lowerBound) ... Float(bounds.upperBound),
            step: Float(step),
            label: label,
            minimumValueLabel: minimumValueLabel,
            maximumValueLabel: maximumValueLabel,
            onEditingChanged: onEditingChanged
        )
    }
}
