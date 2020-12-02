//
//  ViewController.swift
//  lab3
//
//  Created by Alex on 24.11.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var taxPctSlider: UISlider!
    @IBOutlet weak var taxPctLabel: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var pick: UISegmentedControl!
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateTapped(sender : AnyObject) {
        var total = Double((totalTextField.text! as NSString).doubleValue)
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)

        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""

        for (tipPct, tipValue) in possibleTips {
            results += "\(tipPct)%: \(tipValue)\n"
        }
        
        switch Int(total) {
        case 10:
            results += "Special discount: 1"
        case 100:
            results += "Special discount: 10"
        case 1000:
            results += "Special discount: 25"
        case 777:
            results += "Special discount: 17"
        default:
            results += "No special discount"
        }
        
        resultTextView.text = results
    }
    
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    func refreshUI() {
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        resultTextView.text = ""
    }
}

