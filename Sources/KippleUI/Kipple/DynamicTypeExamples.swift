// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

// TODO: Migrate to KippleUIPreviews
/// Examples of all Dynamic Type sizes available.
private struct DynamicTypeExamples: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(DynamicTypeSize.allCases, id: \.self) { size in
                    VStack(alignment: .leading) {
                        Text(String(describing: size))
                        Text("Lorem ipsum dolor sit amet")
                            .dynamicTypeSize(size)
                    }
                }
            }
        }
    }
}

// MARK: - Previews

struct DynamicTypeExamples_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTypeExamples()
    }
}

// # RivaUI Examples

// This folder is meant to contain `private`, unexposed examples of various SwiftUI / UIKit practices for easy reference.
