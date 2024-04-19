//
//  BrightnessController.swift
//  nuflicker
//
//  Created by Donny on 4/18/24.
//

import Foundation
import IOKit

class BrightnessController {
    private var service: io_service_t {
        return IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"))
    }

    func setBrightness(_ brightness: Float) {
        var iterator: io_iterator_t = 0
        let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"))
        IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, brightness)
        IOObjectRelease(service)
    }
    
}
