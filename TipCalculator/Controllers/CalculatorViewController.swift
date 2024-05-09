//
//  ViewController.swift
//  TipCalculator
//
//  Created by IFTS40 on 07/05/24.
//

import UIKit

class CalculatorViewController: UIViewController {

    // Outlets for UI elements connected in storyboard
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    // Variables to store user input and calculation results
    var chosenTip: Double = 0.10  // Default tip percentage (10%)
    var numberOfPeople: Int = 2     // Default number of people splitting the bill
    var totalPP: Double?           // Total amount per person (initially nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set keyboard type for bill text field
        billTextField.keyboardType = .decimalPad

        // Set minimum value for stepper (number of people)
        stepper.minimumValue = 2

        // Create tap gesture recognizer to dismiss keyboard when tapping outside text field
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        downView.addGestureRecognizer(tapGesture)
    }

    // Function called when tap gesture recognized (dismisses keyboard)
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // Action function called when a tip percentage button is pressed
    @IBAction func tipChanged(_ sender: UIButton) {
        // Dismiss keyboard to prevent further input while processing tip selection
        billTextField.endEditing(true)

        // Deselect all tip buttons to avoid overlapping selections
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false

        // Select the pressed button for visual indication
        sender.isSelected = true

        // Extract the tip percentage value from the button title (remove "%")
        chosenTip = Double(sender.titleLabel!.text!.dropLast())! / 100

        // Convert the tip percentage to a decimal value (e.g., 10% becomes 0.1)
    }

    // Action function called when stepper value changes (number of people)
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Dismiss keyboard to prevent further input while processing stepper change
        billTextField.endEditing(true)

        // Update split number label to display the current stepper value (number of people)
        splitNumberLabel.text = String(format: "%.0f", sender.value)

        // Update the number of people variable based on the stepper value
        numberOfPeople = Int(sender.value)
    }

    // Action function called when "Calculate" button is pressed
    @IBAction func calculatePressed(_ sender: UIButton) {

        // Extract bill amount from text field, handle potential errors
        if let totalString = billTextField.text?.replacingOccurrences(of: ",", with: "."), let total = Double(totalString) {

            // Calculate total amount per person (including tip)
            totalPP = (total + (total * chosenTip)) / Double(numberOfPeople)

            // Perform segue to "Results" view controller with calculated data
            performSegue(withIdentifier: "toResults", sender: self)
        } else {
            // Clear bill text field if invalid input is detected
            billTextField.text = ""
        }
    }

    // Function to prepare data for segue to "Results" view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            let nextVc = segue.destination as! ResultsViewController

            // Pass calculated data to the "Results" view controller
            nextVc.numPeople = numberOfPeople
            nextVc.totalPP = totalPP
            nextVc.percentage = Int(chosenTip * 100) // Convert tip percentage to integer for display
        }
    }
}
