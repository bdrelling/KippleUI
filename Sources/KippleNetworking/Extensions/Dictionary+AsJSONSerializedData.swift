// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension Dictionary {
    func asJSONSerializedData() throws -> Data {
        let options: JSONSerialization.WritingOptions

        if #available(iOS 11.0, OSX 10.13, tvOS 11.0, watchOS 4.0, *) {
            options = .sortedKeys
        } else {
            options = []
        }

        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
}
