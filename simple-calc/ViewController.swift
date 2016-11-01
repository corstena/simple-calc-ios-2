//
//  ViewController.swift
//  simple-calc
//
//  Created by iGuest on 10/24/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rpnLabel: UILabel!
    var firstValue = Double()
    var secondValue = Double()
    var operation = "nothing"
    var operationSelected = false
    var functionValueArray = [Double]()
    var rpnMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if operationSelected {
            resultLabel.text = ""
            operationSelected = false
        }
        if !(sender.titleLabel!.text! == "." && (resultLabel.text!.contains(".") || resultLabel.text! == "")) {
            resultLabel.text = resultLabel.text! + sender.titleLabel!.text!
        }
    }

    @IBAction func operationButtonPressed(_ sender: UIButton) {
        if !rpnMode {
            if resultLabel.text! != "" && !operationSelected {
                firstValue = Double(resultLabel.text!)!
                resultLabel.text = sender.titleLabel!.text!
                operation = sender.titleLabel!.text!
                operationSelected = true
            }
        }
    }
    
    @IBAction func historyButton(_ sender: UIButton) {
        
    }
    
    @IBAction func equalsButton(_ sender: UIButton) {
        if !rpnMode {
            if resultLabel.text! != "" && !checkForOperation() {
                secondValue = Double(resultLabel.text!)!
                switch operation {
                case "+":
                    resultLabel.text = String(firstValue + secondValue)
                case "-":
                    resultLabel.text = String(firstValue - secondValue)
                case "x":
                    resultLabel.text = String(firstValue * secondValue)
                case "/":
                    resultLabel.text = String(firstValue / secondValue)
                case "%":
                    resultLabel.text = String(firstValue.truncatingRemainder(dividingBy: secondValue))
                case "count":
                    updateArray()
                    resultLabel.text = String(functionValueArray.count)
                case "average":
                    updateArray()
                    var total : Double = 0.0
                    for value in functionValueArray {
                        total = total + value
                    }
                    resultLabel.text = String(total / Double(functionValueArray.count))
                default:
                    resultLabel.text = "Error! Invalid Operation"
                }
                resetValues()
            }
        }
    }
    
    func checkForOperation() -> Bool {
        if resultLabel.text!.contains("+") || resultLabel.text!.contains("-") || resultLabel.text!.contains("x") ||
                resultLabel.text!.contains("/") || resultLabel.text!.contains("%") {
            return true
        }
        return false
    }
    
    @IBAction func countButton(_ sender: UIButton) {
        if !rpnMode {
            if resultLabel.text != "" && !operationSelected {
                updateArray()
                operation = "count"
            }
        }
    }
    
    @IBAction func averageButton(_ sender: UIButton) {
        if !rpnMode {
            if resultLabel.text != "" && !operationSelected {
                updateArray()
                operation = "average"
            }
        }
    }
    
    @IBAction func factorialButton(_ sender: UIButton) {
        if !rpnMode {
            if resultLabel.text != "" && !operationSelected {
                var result = 1
                let limit : Int = Int(resultLabel.text!)!
                for currentMultiplier in 1...limit {
                    result *= currentMultiplier
                }
                resultLabel.text = String(result)
            }
        }
    }
    
    func resetValues() {
        firstValue = 0.0
        secondValue = 0.0
        operation = "nothing"
        functionValueArray = [Double]()
    }
    
    @IBAction func rpnFunction(_ sender: UIButton) {
        if rpnMode {
            let command = resultLabel.text!
            let split = command.components(separatedBy:" ")
            if split.count >= 2 || command == "Fact"{
                let operation = sender.titleLabel!.text!
                switch operation {
                case "+":
                    resultLabel.text = String(Double(split[0])! + Double(split[1])!)
                case "-":
                    resultLabel.text = String(Double(split[0])! - Double(split[1])!)
                case "x":
                    resultLabel.text = String(Double(split[0])! * Double(split[1])!)
                case "/":
                    resultLabel.text = String(Double(split[0])! / Double(split[1])!)
                case "%":
                    resultLabel.text = String(Double(split[0])!.truncatingRemainder(dividingBy: Double(split[1])!))
                case "Count":
                    resultLabel.text = String(split.count)
                case "Avg":
                    var total = 0.0
                    for value in split {
                        total = total + Double(value)!
                    }
                    resultLabel.text = String(total / Double(split.count))
                case "Fact":
                    var result = 1
                    let limit : Int = Int(split[0])!
                    for currentMultiplier in 1...limit {
                        result *= currentMultiplier
                    }
                    resultLabel.text = String(result)
                default:
                    resultLabel.text = "Error! Invalid Operation"
                }
            }
        }
    }
    
    func updateArray() {
        functionValueArray.append(Double(resultLabel.text!)!)
        resultLabel.text = ""
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        resultLabel.text = ""
        resetValues()
    }
    
    @IBAction func rpnToggleButton(_ sender: UIButton) {
        if !rpnMode {
            rpnMode = true
            rpnLabel.text = "RPN mode is ON"
        } else {
            rpnMode = false
            rpnLabel.text = "RPN mode in OFF"
        }
        
    }
    
    @IBAction func rpnSpace(_ sender: UIButton) {
        resultLabel.text = resultLabel.text! + " "
    }
}

