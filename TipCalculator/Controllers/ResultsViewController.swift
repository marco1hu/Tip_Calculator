//
//  ResultsViewController.swift
//  TipCalculator
//
//  Created by IFTS40 on 09/05/24.
//

import UIKit

class ResultsViewController: UIViewController {

    // Outlets for UI elements connected in storyboard
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!

    // Variables to receive data passed through segue
    var totalPP: Double?  // Total amount per person (passed from CalculatorViewController)
    var numPeople: Int?   // Number of people splitting the bill (passed from CalculatorViewController)
    var percentage: Int?  // Tip percentage chosen (passed from CalculatorViewController)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Format and display total amount per person with two decimal places
        totalLabel.text = String(format: "%.2f", totalPP!)

        // Create settings label text displaying number of people, tip percentage, and tip amount
        settingsLabel.text = "Split between \(numPeople!) people with \(percentage!)% tip."
    }

    // Action function for "Recalculate" button (likely dismisses this view)
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
