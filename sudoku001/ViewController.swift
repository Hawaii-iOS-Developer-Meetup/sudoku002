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
        solvePuzzle()
    }
    
    func solvePuzzle() {
        
        // end condition
        // all the cans have only one pringle
        
        
    }
    
//    vertical scan
//    horizontal scan
//    block scan
    
//    [0,0], [0,1], 0,8

    let blockOne = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
    let blockTwo = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
    let blockThree = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]

    let blockFour = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
    let blockFive = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
    let blockSix = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]
    
    let blockSeven = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
    let blockEight = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
    let blockNine = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]

    
    
    
    
//    let blockTwo = 0,3 to 0,5 and 1,3 to 1,5 and 2,3 to 2,5
//    let blockThree = 0,6 to 0,8 and 1,6 to 1,8 and 2,6 to 2,8
//    let blockFour = 3,0 to 3,2 and 4,0 to 4,2 and 5,0 to 5,2
//    let blockFive = 3,3 to 3,5 and 4,3 to 4,5 and 5,3 to 5,5
//    let blockSix = 3,6 to 3,8 and 4,6 to 4,8 and 5,6 to 5,8
//    let blockSeven = 6,0 to 6,2 and 7,0 to 7,2 and 8,0 to 8,2
//    let blockEight = 6,3 to 6,5 and 7,3 to 7,5 and 8,3 to 8,5
//    let blockNine = 6,6 to 6,8 and 7,6 to 7,8 and 8,6 to 8,8
    
    
    
    
    // do this until every can has only one pringle:
    // for 0,0
      // scan 0,0 to 0,9
        // knock out anything that exists elsewhere
      // scan 0,0 to 9,0
        // knock out anything that exists elsewhere
      // scan blockOne
        // knock out anything that exists elsewhere

    
    //for 6,6
      // scan 0,6 to 8,6
      // scan 6,0 to 6,8
      // scan blockFive
    
    //
    
    

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
    
    //Sets a timer to update the latest data for the Sudoku puzzle every second
    func startOneSecondTimer() {
        oneSecondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(printSudokuGrid), userInfo: nil, repeats: true);
    }
}
