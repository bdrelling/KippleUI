// Copyright © 2022 Brian Drelling. All rights reserved.

#if DEBUG && canImport(UIKit)

    import UIKit

    /*

     iOS Font Weight Reference:

     UltraLight or ExtraLight
     Thin
     Light
     Regular or Normal
     Medium
     SemiBold or DemiBold
     Bold
     Heavy or ExtraBold
     Black

     */

    public extension UIFont {
        static func printNames() {
            UIFont.familyNames
                .sorted()
                .forEach { familyName in
                    let fontNames = UIFont.fontNames(forFamilyName: familyName)
                    print(familyName, fontNames)
                }
        }
    }

#endif
