//
//  BlendingView.swift
//  nuflicker
//
//  Created by Donny on 4/18/24.
//

import Foundation
import Cocoa

class BlendingView: NSView {
    
    var blendColor: NSColor = .clear { didSet { updateColors() } }
    var blendMode: CGBlendMode = .normal { didSet { setNeedsDisplay(bounds) } }
    var visualEffectView: NSVisualEffectView!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupVisualEffectView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVisualEffectView()
    }
    
    private func setupVisualEffectView() {
        visualEffectView = NSVisualEffectView(frame: self.bounds)
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.state = .active
        visualEffectView.material = .sidebar // Choose the appropriate material
        visualEffectView.wantsLayer = true
        addSubview(visualEffectView)
        visualEffectView.layer?.backgroundColor = blendColor.cgColor
    }
    
    func updateColors() {
        visualEffectView.layer?.backgroundColor = blendColor.withAlphaComponent(CGFloat(self.alphaValue)).cgColor
        visualEffectView.layer?.opacity = Float(self.alphaValue)
        setNeedsDisplay(bounds)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let context = NSGraphicsContext.current?.cgContext else { return }
        
        context.setBlendMode(blendMode)
        context.setFillColor(blendColor.withAlphaComponent(CGFloat(self.alphaValue)).cgColor)
        context.fill(bounds)
    }
}
