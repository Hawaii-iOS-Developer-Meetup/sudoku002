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
    var sudokuGrid: [[[Int]]] = [[[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []],
                                 [[], [], [], [], [], [], [], [], []]]
    let numberOfRows = 9
    let numberOfColumns = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGrid(withPossibleNumbers: possibleNumbers)
        printSudokuGrid(toTextView: textView)
    }
    
    func initGrid(withPossibleNumbers inputPossibleNumbers: [Int]) {
        for i in 0..<numberOfRows {
            for j in 0..<numberOfColumns {
                sudokuGrid[i][j] = possibleNumbers
            }
        }
    }
    
    func printSudokuGrid(toTextView inputTextView: UITextView) {
        
        //1. Init the
        var returnText = "000000000\n000000000\n000000000\n000000000\n000000000\n000000000\n000000000\n000000000\n000000000"
        
        //2. Print out a item for each cell
        for i in 0..<numberOfRows {
            print("\n")
            for j in 0..<numberOfColumns {
                print(sudokuGrid[i][j])
            }
        }
        
        //3. Set the label with the data from the sudoku grid
        inputTextView.text = returnText
    }
    
    //TODO: Set up a 1 second timer that calls printSudokuGrid(toTextView
}












