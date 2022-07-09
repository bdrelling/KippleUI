// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

/// The device model to use for previews. Raw value corresponds to an explicit string matching the simulator.
public enum PreviewDeviceType: String {
    // This enum is sorted by the first operating system version a device appeared on,
    // along with the date that the operating system version released.

    // For more detailed information, see https://iosref.com/ios

    // MARK: iPhones

    // iOS 9 (2015)
    case iPhone6s = "iPhone 6s"
    case iPhone6sPlus = "iPhone 6s Plus"
    case iPhoneSEGen1 = "iPhone SE (1st generation)"

    // iOS 10 (2016)
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"

    // iOS 11 (2017)
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"

    // iOS 12 (2018)
    case iPhoneXr = "iPhone Xʀ"
    case iPhoneXs = "iPhone Xs"
    case iPhoneXsMax = "iPhone Xs Max"

    // iOS 13 (2019)
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhoneSEGen2 = "iPhone SE (2nd generation)"
    case iPodTouchGen7 = "iPod touch (7th generation)"

    // iOS 14 (2020)
    case iPhone12 = "iPhone 12"
    case iPhone12Mini = "iPhone 12 mini"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"

    // iOS 15 (2021)
    case iPhone13 = "iPhone 13"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    // Temporarily disabled as it's not working in Xcode 13.4.1 by default.
//    case iPhoneSEGen3 = "iPhone SE (3rd generation)"

    // MARK: iPads

    // iPadOS 8 (2014)
    case iPadAir2 = "iPad Air 2"

    // iPadOS 9 (2015)
    case iPadMini4 = "iPad mini 4"
    case iPadPro97Inch = "iPad Pro (9.7-inch)"
    case iPadPro129InchGen1 = "iPad Pro (12.9-inch) (1st generation)"

    // iPadOS 10 (2016)
    case iPadGen5 = "iPad (5th generation)"
    case iPadPro105Inch = "iPad Pro (10.5-inch)"
    case iPadPro129InchGen2 = "iPad Pro (12.9-inch) (2nd generation)"

    // iPadOS 11 (2017)
    case iPadGen6 = "iPad (6th generation)"

    // iPadOS 12 (2018)
    case iPadAirGen3 = "iPad Air (3rd generation)"
    case iPadMiniGen5 = "iPad mini (5th generation)"
    case iPadPro11InchGen1 = "iPad Pro (11-inch) (1st generation)"
    case iPadPro129InchGen3 = "iPad Pro (12.9-inch) (3rd generation)"

    // iPadOS 13 (2019)
    case iPadGen7 = "iPad (7th generation)"
    case iPadPro11InchGen2 = "iPad Pro (11-inch) (2nd generation)"
    case iPadPro129InchGen4 = "iPad Pro (12.9-inch) (4th generation)"

    // iPadOS 14 (2020)
    case iPadGen8 = "iPad (8th generation)"
    case iPadAirGen4 = "iPad Air (4th generation)"
    case iPadPro11InchGen3 = "iPad Pro (11-inch) (3rd generation)"
    case iPadPro129InchGen5 = "iPad Pro (12.9-inch) (5th generation)"

    // iPadOS 15 (2021)
    case iPadGen9 = "iPad (9th generation)"
    case iPadAirGen5 = "iPad Air (5th generation)"
    case iPadMiniGen6 = "iPad mini (6th generation)"
}

// MARK: - Extensions

public extension PreviewDevice {
    init(_ deviceType: PreviewDeviceType) {
        self.init(rawValue: deviceType.rawValue)
    }
}
