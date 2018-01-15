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
        
        //1. Init the label
        var returnText = ""
        
        //2. Print out a item for each cell
        for i in 0..<numberOfRows {
            for j in 0..<numberOfColumns {
                
                let iteratedCountOfPossibleNumbers = countOfPossibleNumbersLeftInCell(withRow: i, andColumn: j)
                
                var iteratedString = ""
                if iteratedCountOfPossibleNumbers > 1 {
                    iteratedString = "-"
                } else {
                    let iteratedArrayOfPossibleNumbers = sudokuGrid[i][j]
                    iteratedString = String.init(iteratedArrayOfPossibleNumbers[0])
                }
                
                returnText.append(iteratedString)
            }
            returnText.append("\n")
        }
        
        //3. Set the label with the data from the sudoku grid
        inputTextView.text = returnText
    }
    
    func countOfPossibleNumbersLeftInCell(withRow inputRow: Int, andColumn inputColumn: Int) -> Int {
        let arrayOfPossibleNumbersInCell = sudokuGrid[inputRow][inputColumn]
        let returnCountOfPossibleNumbersInCell = arrayOfPossibleNumbersInCell.count
        return returnCountOfPossibleNumbersInCell
    }
    
    //TODO: Create a method to set a cell with a seeded value
    func setAnswerForCell(withRow inputRow: Int, andColumn inputColumn: Int, withAnswer inputAnswer: Int) {
        sudokuGrid[inputRow][inputColumn] = [inputAnswer]
    }
    
    //sets the lengthy array with an array containing just a single number, the right answer.
    //TODO: Set up a 1 second timer that calls printSudokuGrid(toTextView
}
