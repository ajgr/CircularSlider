//
//  ViewController.swift
//  CircularSlider
//
//  Created by Arthur Roolfs on 8/10/17.
//
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var circularSlider: CircularSlider!
	@IBOutlet weak var controlValueLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		circularSlider.value = 5.5
		controlValueLabel.text = String(format: "%.2f", circularSlider.value)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Actions
	@IBAction func onSliderThree(_ sender: CircularSlider) {
		controlValueLabel.text = String(format: "%.2f", sender.value)
	}
	
}





