//
//  ScreenAdjuster.swift
//  nuflicker
//
//  Created by Donny on 4/18/24.
//

//import Foundation
//import Cocoa
//import IOKit
//import CoreImage
//
//@mainBackup
//class AppDelegateBackup: NSObject, NSApplicationDelegate {
//
//    var window: NSWindow!
//    var overlayWindow: NSWindow!
//    var alphaSlider: NSSlider!
//    var colorWell: NSColorWell!
//    var imageView: NSImageView!
//    
//    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        // Create the main application window
//        // Setup the main control panel window
//           self.window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 280, height: 200),
//                                   styleMask: [.titled, .closable, .miniaturizable, .resizable],
//                                   backing: .buffered, defer: false)
//           window.center()
//           window.title = "Control Panel"
//           window.isReleasedWhenClosed = false
//           window.makeKeyAndOrderFront(nil)
//               
//               // Create an overlay window
//         createOverlay()
//        
//        // Add slider for adjusting the overlay alpha
//               alphaSlider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(alphaSliderChanged(_:)))
//               alphaSlider.frame = CGRect(x: 20, y: 110, width: 240, height: 20)
//               window.contentView?.addSubview(alphaSlider)
//
//               // Add color well for selecting tint color
//               colorWell = NSColorWell(frame: CGRect(x: 20, y: 70, width: 240, height: 30))
//               colorWell.color = NSColor.red // Default color
//               colorWell.target = self
//               colorWell.action = #selector(colorWellChanged(_:))
//               window.contentView?.addSubview(colorWell)
//
//               // Initialize overlay color and image
//               updateOverlayColor()
//    }
//
//    func applicationWillTerminate(_ aNotification: Notification) {
//        // Insert code here to tear down your application
//    }
//    
//    func setBrightness(_ brightness: Float) {
//        var iterator: io_iterator_t = 0
//        let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"))
//        IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, brightness)
//        IOObjectRelease(service)
//    }
//    
//    func enableNightShift(_ enabled: Bool) {
//        if let display = NSClassFromString("CoreDisplay_Display") as? NSObject.Type {
//            let sel = NSSelectorFromString("displayWithDisplayID:")
//            let displayID = CGMainDisplayID()
//            if let displayInstance = display.perform(sel, with: displayID as NSNumber)?.takeUnretainedValue() {
//                let setStyleSel = NSSelectorFromString("setWhitePointAdaptivityStyle:")
//                displayInstance.perform(setStyleSel, with: enabled ? 3 : 1)
//            }
//        }
//    }
//    func createOverlay() {
//         let screenRect = NSScreen.main!.frame
//         overlayWindow = NSWindow(contentRect: screenRect, styleMask: .borderless, backing: .buffered, defer: false)
//         overlayWindow.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.maximumWindow)))
//         overlayWindow.isOpaque = false
////        overlayWindow.backgroundColor = NSColor(calibratedRed: 0.0, green: 0.5, blue: 0.0, alpha: 0.2) // Light red tint
//         overlayWindow.ignoresMouseEvents = true // Allows clicks to pass through the window
//         overlayWindow.makeKeyAndOrderFront(nil)
//     }
//    
//    @objc func alphaSliderChanged(_ sender: NSSlider) {
//         updateOverlayColor()
//     }
//
//     @objc func colorWellChanged(_ sender: NSColorWell) {
//         updateOverlayColor()
//     }
//
//     func updateOverlayColor() {
//         let color = colorWell.color
//         let alpha = CGFloat(alphaSlider.floatValue)
//         overlayWindow.backgroundColor = color.withAlphaComponent(alpha)
//     }
//}
