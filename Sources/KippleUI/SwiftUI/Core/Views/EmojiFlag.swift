// Copyright © 2024 Brian Drelling. All rights reserved.

import SwiftUI

public struct EmojiFlag: View {
    // MARK: Properties

    private let countryCode: String

    private var emoji: String {
        let base: UInt32 = 127397
        var s = ""
        for v in self.countryCode.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }

    public var body: some View {
        Text(self.emoji)
    }

    // MARK: Initializers

    private init(_ countryCode: String) {
        self.countryCode = countryCode
    }

    public init(_ region: Locale.Region) {
        self.init(region.identifier)
    }
}

// MARK: - Extensions

private extension Locale {
    static var allCountries: [Region] {
        Locale.Region.isoRegions
            .filter(\.subRegions.isEmpty)
    }
}

// MARK: - Previews

#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 32) {
            Text("Countries: \(Locale.allCountries.filter { $0.subRegions.count == 0 }.count)")
                .font(.title3)

            VStack(alignment: .leading) {
                ForEach(Locale.allCountries, id: \.self) { country in
                    HStack {
                        EmojiFlag(country)
                        Text(Locale.current.localizedString(forRegionCode: country.identifier) ?? "UNKNOWN")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}
