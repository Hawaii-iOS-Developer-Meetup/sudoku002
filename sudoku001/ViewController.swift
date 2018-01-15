//
//  ViewController.swift
//  sudoku001
//
//  Created by David on 1/13/18.
//  Copyright © 2018 Vision Runner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    //1. Set up possible numbers into an array
    var possibleNumbers: [Int] = [1,2,3,4,5,6,7,8,9]
    var sudokuGrid: [[[Int]]] = [[[]]]
    let numberOfRows = 9
    let numberOfColumns = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printSudokuGrid(withTextView: textView)
    }
    
    func initGrid(withPossibleNumbers inputPossibleNumbers: [Int]) {
        for i in 0..<numberOfRows {
            for j in 0..<numberOfColumns {
                sudokuGrid[i][j] = possibleNumbers
            }
        }
    }
    
    func printSudokuGrid(withTextView inputTextView: UITextView) {
        inputTextView.text = "000000000\n000000000\n000000000\n000000000\n000000000\n000000000\n000000000\n000000000\n000000000"
    }
}












