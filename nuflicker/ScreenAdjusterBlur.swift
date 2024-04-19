//
//  ScreenAdjuster.swift
//  nuflicker
//
//  Created by Donny on 4/18/24.
//

import Foundation
import Cocoa
import IOKit
import CoreImage

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var overlayWindow: NSWindow!
    var alphaSlider: NSSlider!
    var colorWell: NSColorWell!
    var blendModeSelector: NSPopUpButton!
    var overlayView: BlendingView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupMainWindow()
        setupOverlayWindow()
    }

    func setupMainWindow() {
        self.window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 280, height: 250),
                               styleMask: [.titled, .closable, .miniaturizable, .resizable],
                               backing: .buffered, defer: false)
        window.center()
        window.title = "Control Panel"
        window.isReleasedWhenClosed = false
        window.makeKeyAndOrderFront(nil)

        alphaSlider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(alphaSliderChanged(_:)))
        alphaSlider.frame = CGRect(x: 20, y: 180, width: 240, height: 20)
        window.contentView?.addSubview(alphaSlider)

        colorWell = NSColorWell(frame: CGRect(x: 20, y: 140, width: 240, height: 30))
        colorWell.color = NSColor.red
        colorWell.target = self
        colorWell.action = #selector(colorWellChanged(_:))
        window.contentView?.addSubview(colorWell)

        blendModeSelector = NSPopUpButton(frame: CGRect(x: 20, y: 100, width: 240, height: 30), pullsDown: false)
        blendModeSelector.addItems(withTitles: ["Normal", "Multiply", "Screen", "Overlay"])
        blendModeSelector.action = #selector(blendModeChanged(_:))
        blendModeSelector.target = self
        setBrightness(0.5);
        window.contentView?.addSubview(blendModeSelector)
    }
    
    func setBrightness(_ brightness: Float) {
        var iterator: io_iterator_t = 0
        let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"))
        IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, brightness)
        IOObjectRelease(service)
    }
    

    func setupOverlayWindow() {
        let screenRect = NSScreen.main!.frame
        overlayWindow = NSWindow(contentRect: screenRect, styleMask: .borderless, backing: .buffered, defer: false)
        overlayWindow.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.overlayWindow)))
        overlayWindow.isOpaque = false
        overlayWindow.backgroundColor = NSColor.clear

        overlayView = BlendingView(frame: screenRect)
        overlayView.blendColor = colorWell.color
        overlayView.alphaValue = Double(alphaSlider.floatValue)
        overlayWindow.contentView = overlayView
        overlayWindow.makeKeyAndOrderFront(nil)
        overlayWindow.ignoresMouseEvents = true
    }

    @objc func alphaSliderChanged(_ sender: NSSlider) {
        setBrightness(sender.floatValue)
        overlayView.alphaValue = Double(sender.floatValue)
    }

    @objc func colorWellChanged(_ sender: NSColorWell) {
        overlayView.blendColor = sender.color
    }

    @objc func blendModeChanged(_ sender: NSPopUpButton) {
        let selectedTitle = sender.titleOfSelectedItem ?? "Normal"
      
        switch selectedTitle {
        case "Multiply":
            overlayView.blendMode = .multiply
        case "Screen":
            overlayView.blendMode = .screen
        case "Overlay":
            overlayView.blendMode = .overlay
        default:
            overlayView.blendMode = .normal
        }
    }
    
    
}


//class AppDelegate: NSObject, NSApplicationDelegate {
//
//    var window: NSWindow!
//    var overlayWindow: NSWindow!
//    var alphaSlider: NSSlider!
//    var colorWell: NSColorWell!
//    var visualEffectView: NSVisualEffectView!
//
//    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        setupMainWindow()
//        setupOverlayWindow()
//    }
//
//    func setupMainWindow() {
//        self.window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 280, height: 200),
//                               styleMask: [.titled, .closable, .miniaturizable, .resizable],
//                               backing: .buffered, defer: false)
//        window.center()
//        window.title = "Control Panel"
//        window.isReleasedWhenClosed = false
//        window.makeKeyAndOrderFront(nil)
//
//        // Add slider for adjusting the overlay alpha
//        alphaSlider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(alphaSliderChanged(_:)))
//        alphaSlider.frame = CGRect(x: 20, y: 110, width: 240, height: 20)
//        window.contentView?.addSubview(alphaSlider)
//
//        // Add color well for selecting tint color
//        colorWell = NSColorWell(frame: CGRect(x: 20, y: 70, width: 240, height: 30))
//        colorWell.color = NSColor.red // Default color
//        colorWell.target = self
//        colorWell.action = #selector(colorWellChanged(_:))
//        window.contentView?.addSubview(colorWell)
//    }
//
//    func setupOverlayWindow() {
//        let screenRect = NSScreen.main!.frame
//        overlayWindow = NSWindow(contentRect: screenRect, styleMask: .borderless, backing: .buffered, defer: false)
//        overlayWindow.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.floatingWindow)))
//        overlayWindow.isOpaque = false
//        overlayWindow.backgroundColor = NSColor.clear
//
//        // Set up visual effect view
//        visualEffectView = NSVisualEffectView(frame: screenRect)
//        visualEffectView.blendingMode = .behindWindow
//        visualEffectView.state = .active
//        visualEffectView.material = .hudWindow // or .sheet, .windowBackground, etc., depending on desired effect
//
//        // Allow the visual effect view to act as a color overlay
//        visualEffectView.wantsLayer = true
//        visualEffectView.layer?.backgroundColor = NSColor.red.cgColor
//        visualEffectView.layer?.opacity = 0.5 // start with some default opacity
//
//        overlayWindow.contentView = visualEffectView
//        overlayWindow.makeKeyAndOrderFront(nil)
//        overlayWindow.ignoresMouseEvents = true
//    }
//
//    @objc func alphaSliderChanged(_ sender: NSSlider) {
//        visualEffectView.layer?.opacity = sender.floatValue
//    }
//
//    @objc func colorWellChanged(_ sender: NSColorWell) {
//        visualEffectView.layer?.backgroundColor = sender.color.cgColor
//    }
//}
