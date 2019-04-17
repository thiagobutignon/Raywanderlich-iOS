//
//  ViewController.swift
//  ConcurrencyTest
//
//  Created by Thiago B Claramunt on 17/04/19.
//  Copyright © 2019 Thiago B Claramunt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var prime: UIButton!
    @IBAction func calculatePrimeNumbers(_ sender: Any) {
        /* Se eu quiser que meu código execute na main tread eu faço:
         let mainQueue = OperationQueue.main
         Mas isso não irá parar o travamento da UI do Date Picker!
         */
        enablePrimeButton(false)
        let queue = OperationQueue()
// Para rodar a concorrência em uma classe em um novo arquivo!
// let operation = CalculatePrimeOperation()
        queue.addOperation {
            for number in 0 ... 100_000 {
                let isPrimeNumber = self.isPrime(number: number)
                print("\(number) is prime: \(isPrimeNumber  )")
            }
           
            OperationQueue.main.addOperation {
                self.enablePrimeButton(true)
            }
        }
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func enablePrimeButton(_ isEnabled: Bool) {
       prime.isEnabled = isEnabled
        if isEnabled {
            prime.setTitle("Calculate Prime Numbers", for: .normal)
        } else {
            prime.setTitle("Calculating...", for: .normal)
        }
    }
    
    func isPrime(number: Int) -> Bool {
        if number <= 1 {
            return false
        }
        if number <= 3 {
            return true
        }
        
        var i: Int = 2
        while i * i <= number {
            if number % i == 0 {
                return false
            }
            i = i + 2
        }
        return true
    }
    
}

