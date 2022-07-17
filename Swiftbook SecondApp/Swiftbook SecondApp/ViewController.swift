//
//  ViewController.swift
//  Swiftbook SecondApp
//
//  Created by Евгений Бияк on 17.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updateView(withValue: sender.value)
    }
    
    private func updateView(withValue value: Float) {
        let celsius = slider.value.rounded()
        let fahrenheit = (celsius * 9 / 5 + 32).rounded()
        celsiusLabel.text = "\(celsius)ºC"
        fahrenheitLabel.text = "\(fahrenheit)ºF"
    }
}

