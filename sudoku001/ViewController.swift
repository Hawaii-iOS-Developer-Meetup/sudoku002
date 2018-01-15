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
    
    var oneSecondTimer: Timer = Timer()
    
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
        setGridWithPrintedAnswers()
        printSudokuGrid()
        startOneSecondTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        oneSecondTimer.invalidate()
    }
    
    func initGrid(withPossibleNumbers inputPossibleNumbers: [Int]) {
        for i in 0..<numberOfRows {
            for j in 0..<numberOfColumns {
                sudokuGrid[i][j] = possibleNumbers
            }
        }
    }
    
    @objc func printSudokuGrid() {
        
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
        textView.text = returnText
        
        print("printSudokuGrid called. Display updated")
    }
    
    func countOfPossibleNumbersLeftInCell(withRow inputRow: Int, andColumn inputColumn: Int) -> Int {
        let arrayOfPossibleNumbersInCell = sudokuGrid[inputRow][inputColumn]
        let returnCountOfPossibleNumbersInCell = arrayOfPossibleNumbersInCell.count
        return returnCountOfPossibleNumbersInCell
    }
    
    //Sets a cell with the printed answer value
    func setAnswerForCell(withRow inputRow: Int, andColumn inputColumn: Int, withAnswer inputAnswer: Int) {
        sudokuGrid[inputRow][inputColumn] = [inputAnswer]
    }
    
    //Writes in the printed answer
    func setGridWithPrintedAnswers() {
        setAnswerForCell(withRow: 0, andColumn: 0, withAnswer: 5)
        setAnswerForCell(withRow: 0, andColumn: 1, withAnswer: 3)
        setAnswerForCell(withRow: 0, andColumn: 4, withAnswer: 7)
        
        setAnswerForCell(withRow: 1, andColumn: 0, withAnswer: 6)
        setAnswerForCell(withRow: 1, andColumn: 3, withAnswer: 1)
        setAnswerForCell(withRow: 1, andColumn: 4, withAnswer: 9)
        setAnswerForCell(withRow: 1, andColumn: 5, withAnswer: 5)
        
        setAnswerForCell(withRow: 2, andColumn: 1, withAnswer: 9)
        setAnswerForCell(withRow: 2, andColumn: 2, withAnswer: 8)
        setAnswerForCell(withRow: 2, andColumn: 7, withAnswer: 6)
        
        setAnswerForCell(withRow: 3, andColumn: 0, withAnswer: 8)
        setAnswerForCell(withRow: 3, andColumn: 4, withAnswer: 6)
        setAnswerForCell(withRow: 3, andColumn: 8, withAnswer: 3)

        setAnswerForCell(withRow: 4, andColumn: 0, withAnswer: 4)
        setAnswerForCell(withRow: 4, andColumn: 3, withAnswer: 8)
        setAnswerForCell(withRow: 4, andColumn: 5, withAnswer: 3)
        setAnswerForCell(withRow: 4, andColumn: 8, withAnswer: 1)

        setAnswerForCell(withRow: 5, andColumn: 0, withAnswer: 7)
        setAnswerForCell(withRow: 5, andColumn: 4, withAnswer: 2)
        setAnswerForCell(withRow: 5, andColumn: 8, withAnswer: 6)
        
        setAnswerForCell(withRow: 6, andColumn: 1, withAnswer: 6)
        setAnswerForCell(withRow: 6, andColumn: 6, withAnswer: 2)
        setAnswerForCell(withRow: 6, andColumn: 7, withAnswer: 8)
        
        setAnswerForCell(withRow: 7, andColumn: 3, withAnswer: 4)
        setAnswerForCell(withRow: 7, andColumn: 4, withAnswer: 1)
        setAnswerForCell(withRow: 7, andColumn: 5, withAnswer: 9)
        setAnswerForCell(withRow: 7, andColumn: 8, withAnswer: 5)
        
        setAnswerForCell(withRow: 8, andColumn: 4, withAnswer: 8)
        setAnswerForCell(withRow: 8, andColumn: 7, withAnswer: 7)
        setAnswerForCell(withRow: 8, andColumn: 8, withAnswer: 9)

    }
    
    
    func startOneSecondTimer() {
        
        // Set timer to update the timer label every second
        oneSecondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(printSudokuGrid), userInfo: nil, repeats: true);
    }
    
    //TODO: Set up a 1 second timer that calls printSudokuGrid(toTextView
}
