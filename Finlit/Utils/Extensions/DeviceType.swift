//
//  DeviceType.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 03/04/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {

func machineName() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    return machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
}
}
