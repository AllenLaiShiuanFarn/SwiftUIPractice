//
//  LandmarkList.swift
//  Landmarks
//
//  Created by allenlai on 2021/12/21.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView {
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        let previewDevices: [String] = Device.allCases.map { $0.rawValue }
        let previewDevices: [String] = [
            Device.iPhoneSE2,
            Device.iPhoneXsMax
        ].map { $0.rawValue }
        
        ForEach(previewDevices, id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

// ref: https://developer.apple.com/documentation/swiftui/previewdevice
enum Device: String, CaseIterable {
    case iPhone4s = "iPhone 4s"
    case iPhone5 = "iPhone 5"
    case iPhone5s = "iPhone 5s"
    case iPhone6Plus = "iPhone 6 Plus"
    case iPhone6 = "iPhone 6"
    case iPhone6s = "iPhone 6s"
    case iPhone6sPlus = "iPhone 6s Plus"
    case iPhoneSE1 = "iPhone SE (1st generation)"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXs = "iPhone Xs"
    case iPhoneXsMax = "iPhone Xs Max"
    case iPhoneXʀ = "iPhone Xʀ"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhoneSE2 = "iPhone SE (2nd generation)"
    case iPodTouch7 = "iPod touch (7th generation)"
    case iPad2 = "iPad 2"
    case iPadRetina = "iPad Retina"
    case iPadAir = "iPad Air"
    case iPadMini2 = "iPad mini 2"
    case iPadMini3 = "iPad mini 3"
    case iPadMini4 = "iPad mini 4"
    case iPadAir2 = "iPad Air 2"
    case iPadPro9Point7Inch = "iPad Pro (9.7-inch)"
    case iPadPro12Point9Inch1 = "iPad Pro (12.9-inch) (1st generation)"
    case iPad5 = "iPad (5th generation)"
    case iPadPro12Point9Inch2 = "iPad Pro (12.9-inch) (2nd generation)"
    case iPadPro10Point5Inch = "iPad Pro (10.5-inch)"
    case iPad6 = "iPad (6th generation)"
    case iPad7 = "iPad (7th generation)"
    case iPadPro11Inch1 = "iPad Pro (11-inch) (1st generation)"
    case iPadPro12Point9Inch3 = "iPad Pro (12.9-inch) (3rd generation)"
    case iPadPro11Inch2 = "iPad Pro (11-inch) (2nd generation)"
    case iPadPro12Point9Inch4 = "iPad Pro (12.9-inch) (4th generation)"
    case iPadMini5 = "iPad mini (5th generation)"
    case iPadAir3 = "iPad Air (3rd generation)"
    case iPad8 = "iPad (8th generation)"
    case iPadAir4 = "iPad Air (4th generation)"
}
