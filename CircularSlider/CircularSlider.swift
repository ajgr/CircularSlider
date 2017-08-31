//
//  CircularSlider.swift
//  CircularSlider
//
//  Created by Arthur Roolfs on 8/11/17.
//
//

import UIKit

@IBDesignable
class CircularSlider: UIControl {
	
	@IBInspectable public var baseImg: UIImage?
	@IBInspectable public var indicatorImg: UIImage?
	
	@IBInspectable public var minValue:CGFloat = 1.0
	@IBInspectable public var maxValue:CGFloat = 11.0
	
	// This sets the track length where 360 is a full rotation
	let trackLengthInRadians: CGFloat = 240
	
	// This sets the start of the thumb track. It is in radians starting at 12 o'clock clockwise
	// 240 is therefore 8 o'clock
	let trackStartPoint: CGFloat = 240
	
	var indicatorValue: CGFloat = 0.0
	var sensitivity:CGFloat = 0.01
	var lastLocation = CGPoint.zero
	var isMoving = false

	
	var value:CGFloat = 0.0 {
		didSet {
			if value > maxValue {
				value = maxValue
			}
			if value < minValue {
				value = minValue
			}
			self.indicatorValue = CGFloat((value - minValue) / (maxValue - minValue))
		}
	}
	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.isUserInteractionEnabled = true
		contentMode = .redraw
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		self.isUserInteractionEnabled = true
		contentMode = .redraw
	}
	
	override func awakeFromNib() {
		setNeedsDisplay()
	}
	
	class override var requiresConstraintBasedLayout: Bool {
		return true
	}
		
	override func draw(_ rect: CGRect) {
		
		let context = UIGraphicsGetCurrentContext()
		
		let indicatorAngle: CGFloat = trackLengthInRadians * indicatorValue
		
		//// control base
		baseImg!.draw(in: rect)
		
		//// control indicator
		context?.saveGState()
		context?.translateBy(x: rect.size.width / 2, y: rect.size.width / 2)
		context?.rotate(by: (indicatorAngle + trackStartPoint) * CGFloat.pi / 180)
		let indicatorRect = rect.offsetBy(dx: -rect.size.width / 2, dy: -rect.size.width / 2)
		indicatorImg!.draw(in: indicatorRect)
		
		context?.restoreGState()
	}
	
	// MARK: - Standard Control Overrides
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		super.beginTracking(touch, with: event)
		
		let location = touch.location(in: self)
		isMoving = true
		lastLocation = location
		
		return true
	}
	
	override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		super.continueTracking(touch, with: event)
		
		if isMoving {
			let location = touch.location(in: self)
			updateTracking(with: location)
			setNeedsDisplay()
		}
		self.sendActions(for: UIControlEvents.valueChanged)
		
		return true
	}
	
	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		super.endTracking(touch, with: event)
		isMoving = false
	}
	
	//MARK: - Utility
	func updateTracking(with location: CGPoint) {
		
		let horizontalChange = CGFloat(location.x - lastLocation.x) * sensitivity
		value += horizontalChange * (maxValue - minValue)
		
		let verticalChange = CGFloat(location.y - lastLocation.y) * sensitivity
		value -= verticalChange * (maxValue - minValue)
		
		lastLocation = location
	}
}
















