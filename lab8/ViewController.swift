import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
        
        var userInTheMiddleOfTyping = false
        
        @IBAction func touchDigit(_ sender: UIButton) {
            let digit = sender.currentTitle!
            if userInTheMiddleOfTyping {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
            } else {
                display.text = digit
                userInTheMiddleOfTyping = true
            }
        }
        
        var displayValue: Double {
            get {
                return Double(display.text!)!
            }
            set {
                display.text = String (newValue)
            }
        }
        @IBAction func performOPeration(_ sender: UIButton) {
            userInTheMiddleOfTyping = false
            if  let mathematicalSymbol = sender.currentTitle {
                switch mathematicalSymbol {
                case"π":
                    displayValue = Double.pi
                case"√":
                    displayValue = sqrt(displayValue)
                default:
                    break
                }
            }
        }


}

