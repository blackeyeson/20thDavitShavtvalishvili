//
//  ViewController.swift
//  20thDavitShavtvalishvili
//
//  Created by a on 09.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var date: UIDatePicker!
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("tap to run", for: .normal)
    }
    
    @IBAction func button(_ sender: Any) {
        button.setTitle("running code", for: .normal)
        button.isEnabled = false
        label.text = "0"
        DispatchQueue.global(qos: .utility).async {
            print(self.primes(upTo: 100004))
        }
    }
    
    func primes(upTo rangeEndNumber: Int) -> [Int] {
        let firstPrime = 2
        guard rangeEndNumber >= firstPrime else {
            fatalError("End of range has to be greater than or equal to \(firstPrime)!")
        }
        var numbers = Array(firstPrime...rangeEndNumber)
        
        // Index of current prime in numbers array, at the beginning it is 0 so number is 2
        var currentPrimeIndex = 0
        
        // Check if there is any number left which could be prime
        while currentPrimeIndex < numbers.count {
            // Number at currentPrimeIndex is next prime
            let currentPrime = numbers[currentPrimeIndex]
            
            // Create array with numbers after current prime and remove all that are divisible by this prime
            var numbersAfterPrime = numbers.suffix(from: currentPrimeIndex + 1)
            numbersAfterPrime.removeAll(where: { $0 % currentPrime == 0 })
            
            // Set numbers as current numbers up to current prime + numbers after prime without numbers divisible by current prime
            numbers = numbers.prefix(currentPrimeIndex + 1) + Array(numbersAfterPrime)
            
            // Increase index for current prime
            currentPrimeIndex += 1
        }
        print(numbers)
        if numbers.last! < 100000 {
            return primes(upTo: numbers.last!+10000)
        } else {
            DispatchQueue.main.async {
                self.button.isEnabled = true
                self.label.text = "\(String(describing: numbers.last ?? 0))"
                self.button.setTitle("done", for: .normal)
            }
            return numbers
        }
    }
}

