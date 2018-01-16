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
    
    func solvePuzzle() {
        
        for rowIndex in 0..<numberOfRows {
            for columnIndex in 0..<numberOfColumns {
                
                var cell = sudokuGrid[rowIndex][columnIndex]
                
                // - - - - - - - scans horizontally
                
                var answersFoundInRow: [Int] = []
                
                // scan for other answers in the current row
                for currentColumnInScan in 0..<numberOfColumns {
                    
                    let iteratedCan = sudokuGrid[rowIndex][currentColumnInScan]
                    
                    if isThisCellAnAnswer(withRow: rowIndex, andColumn: currentColumnInScan) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[rowIndex][currentColumnInScan]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInRow.append(foundAnswer)
                        
                        // remove the number from anything that scans it
                        // any box that scans this cell, removes it from its own can
                    } else {
                        // do nothing
                    }
                }
                
//                print(answersFoundInRow)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInRow, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                
                // - - - - - - - - - - scan vertically
                
                var answersFoundInColumn: [Int] = []
                
                // scan for other answers in the current column
                for currentRowInScan in 0..<numberOfRows {
                    
                    let iteratedCan = sudokuGrid[currentRowInScan][columnIndex]
                    
                    if isThisCellAnAnswer(withRow: currentRowInScan, andColumn: columnIndex) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[currentRowInScan][columnIndex]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInColumn.append(foundAnswer)
                    }
                }
                
                print(answersFoundInColumn)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInColumn, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                // - - - - - - - - - -  scan the block
                
                //Sets up blocks for block scans
                let blockOne = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
                let blockTwo = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
                let blockThree = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]
                
                let blockFour = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
                let blockFive = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
                let blockSix = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]
                
                let blockSeven = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
                let blockEight = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
                let blockNine = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]

                let blocks = [blockOne,
                              blockTwo,
                              blockThree,
                              blockFour,
                              blockFive,
                              blockSix,
                              blockSeven,
                              blockEight]
                
                for iteratedBlock in blocks {
                    
                    // if current cell is in block one
                    if isCellInBlock(withCoords: iteratedBlock, andRow: rowIndex, andColumn: columnIndex) {
                        
                        for coordinates in iteratedBlock {
                            
                            var answersFoundInInteratedBlock: [Int] = []
                            
                            for currentIndexOfIteratedBlock in 0..<iteratedBlock.count {
                                let iteratedCan = sudokuGrid[currentIndexOfIteratedBlock]
                                
                                if let iteratedRow = iteratedBlock[currentIndexOfIteratedBlock].first, let iteratedColumn = iteratedBlock[currentIndexOfIteratedBlock].last {
                                    if isThisCellAnAnswer(withRow: iteratedRow, andColumn: iteratedColumn) {
                                        // take the number out of the pringles can
                                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[iteratedRow][iteratedColumn]
                                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                                        answersFoundInInteratedBlock.append(foundAnswer)
                                        print(foundAnswer)
                                    }
                                }
                            }
                            
                            print(answersFoundInInteratedBlock)
                            
                            cell = takeAnswersOutOfCell(withAnswers: answersFoundInInteratedBlock, andCell: sudokuGrid[rowIndex][columnIndex])
                            
                            // set the data after having removed all found horizontal numbers already  the row
                            sudokuGrid[rowIndex][columnIndex] = cell
                            print(coordinates)
                        }
                    }
                }
                
                // if index is identified in blockOne,
                // scan all indices in blockOne
                
                // else if this cell exists in blockTwo
                  // scan block two
                
                // scan block for answers
                // take answer chips out of pringles
                
            }
        }
        
        printSudokuGrid()
        
        
        // - - - - -  solve it all a second time
        
        for rowIndex in 0..<numberOfRows {
            for columnIndex in 0..<numberOfColumns {
                
                var cell = sudokuGrid[rowIndex][columnIndex]
                
                // - - - - - - - scans horizontally
                
                var answersFoundInRow: [Int] = []
                
                // scan for other answers in the current row
                for currentColumnInScan in 0..<numberOfColumns {
                    
                    let iteratedCan = sudokuGrid[rowIndex][currentColumnInScan]
                    
                    if isThisCellAnAnswer(withRow: rowIndex, andColumn: currentColumnInScan) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[rowIndex][currentColumnInScan]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInRow.append(foundAnswer)
                        
                        // remove the number from anything that scans it
                        // any box that scans this cell, removes it from its own can
                    } else {
                        // do nothing
                    }
                }
                
                print(answersFoundInRow)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInRow, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                
                // - - - - - - - - - - scan vertically
                
                var answersFoundInColumn: [Int] = []
                
                // scan for other answers in the current column
                for currentRowInScan in 0..<numberOfRows {
                    
                    let iteratedCan = sudokuGrid[currentRowInScan][columnIndex]
                    
                    if isThisCellAnAnswer(withRow: currentRowInScan, andColumn: columnIndex) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[currentRowInScan][columnIndex]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInColumn.append(foundAnswer)
                    }
                }
                
                print(answersFoundInColumn)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInColumn, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                // - - - - - - - - - -  scan the block
                
                //Sets up blocks for block scans
                let blockOne = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
                let blockTwo = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
                let blockThree = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]
                
                let blockFour = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
                let blockFive = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
                let blockSix = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]
                
                let blockSeven = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
                let blockEight = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
                let blockNine = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]
                
                let blocks = [blockOne,
                              blockTwo,
                              blockThree,
                              blockFour,
                              blockFive,
                              blockSix,
                              blockSeven,
                              blockEight]
                
                for iteratedBlock in blocks {
                    
                    // if current cell is in block one
                    if isCellInBlock(withCoords: iteratedBlock, andRow: rowIndex, andColumn: columnIndex) {
                        
                        for coordinates in iteratedBlock {
                            
                            var answersFoundInInteratedBlock: [Int] = []
                            
                            for currentIndexOfIteratedBlock in 0..<iteratedBlock.count {
                                let iteratedCan = sudokuGrid[currentIndexOfIteratedBlock]
                                
                                if let iteratedRow = iteratedBlock[currentIndexOfIteratedBlock].first, let iteratedColumn = iteratedBlock[currentIndexOfIteratedBlock].last {
                                    if isThisCellAnAnswer(withRow: iteratedRow, andColumn: iteratedColumn) {
                                        // take the number out of the pringles can
                                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[iteratedRow][iteratedColumn]
                                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                                        answersFoundInInteratedBlock.append(foundAnswer)
                                        print(foundAnswer)
                                    }
                                }
                            }
                            
                            print(answersFoundInInteratedBlock)
                            
                            cell = takeAnswersOutOfCell(withAnswers: answersFoundInInteratedBlock, andCell: sudokuGrid[rowIndex][columnIndex])
                            
                            // set the data after having removed all found horizontal numbers already  the row
                            sudokuGrid[rowIndex][columnIndex] = cell
                            print(coordinates)
                        }
                    }
                }
                
                // if index is identified in blockOne,
                // scan all indices in blockOne
                
                // else if this cell exists in blockTwo
                // scan block two
                
                // scan block for answers
                // take answer chips out of pringles
                
            }
        }
        
        printSudokuGrid()
        
        
        // - - - - run the code a third time
        
        for rowIndex in 0..<numberOfRows {
            for columnIndex in 0..<numberOfColumns {
                
                var cell = sudokuGrid[rowIndex][columnIndex]
                
                // - - - - - - - scans horizontally
                
                var answersFoundInRow: [Int] = []
                
                // scan for other answers in the current row
                for currentColumnInScan in 0..<numberOfColumns {
                    
                    let iteratedCan = sudokuGrid[rowIndex][currentColumnInScan]
                    
                    if isThisCellAnAnswer(withRow: rowIndex, andColumn: currentColumnInScan) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[rowIndex][currentColumnInScan]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInRow.append(foundAnswer)
                        
                        // remove the number from anything that scans it
                        // any box that scans this cell, removes it from its own can
                    } else {
                        // do nothing
                    }
                }
                
                print(answersFoundInRow)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInRow, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                
                // - - - - - - - - - - scan vertically
                
                var answersFoundInColumn: [Int] = []
                
                // scan for other answers in the current column
                for currentRowInScan in 0..<numberOfRows {
                    
                    let iteratedCan = sudokuGrid[currentRowInScan][columnIndex]
                    
                    if isThisCellAnAnswer(withRow: currentRowInScan, andColumn: columnIndex) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[currentRowInScan][columnIndex]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInColumn.append(foundAnswer)
                    }
                }
                
                print(answersFoundInColumn)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInColumn, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                // - - - - - - - - - -  scan the block
                
                //Sets up blocks for block scans
                let blockOne = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
                let blockTwo = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
                let blockThree = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]
                
                let blockFour = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
                let blockFive = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
                let blockSix = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]
                
                let blockSeven = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
                let blockEight = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
                let blockNine = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]
                
                let blocks = [blockOne,
                              blockTwo,
                              blockThree,
                              blockFour,
                              blockFive,
                              blockSix,
                              blockSeven,
                              blockEight]
                
                for iteratedBlock in blocks {
                    
                    // if current cell is in block one
                    if isCellInBlock(withCoords: iteratedBlock, andRow: rowIndex, andColumn: columnIndex) {
                        
                        for coordinates in iteratedBlock {
                            
                            var answersFoundInInteratedBlock: [Int] = []
                            
                            for currentIndexOfIteratedBlock in 0..<iteratedBlock.count {
                                let iteratedCan = sudokuGrid[currentIndexOfIteratedBlock]
                                
                                if let iteratedRow = iteratedBlock[currentIndexOfIteratedBlock].first, let iteratedColumn = iteratedBlock[currentIndexOfIteratedBlock].last {
                                    if isThisCellAnAnswer(withRow: iteratedRow, andColumn: iteratedColumn) {
                                        // take the number out of the pringles can
                                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[iteratedRow][iteratedColumn]
                                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                                        answersFoundInInteratedBlock.append(foundAnswer)
                                        print(foundAnswer)
                                    }
                                }
                            }
                            
                            print(answersFoundInInteratedBlock)
                            
                            cell = takeAnswersOutOfCell(withAnswers: answersFoundInInteratedBlock, andCell: sudokuGrid[rowIndex][columnIndex])
                            
                            // set the data after having removed all found horizontal numbers already  the row
                            sudokuGrid[rowIndex][columnIndex] = cell
                            print(coordinates)
                        }
                    }
                }
                
                // if index is identified in blockOne,
                // scan all indices in blockOne
                
                // else if this cell exists in blockTwo
                // scan block two
                
                // scan block for answers
                // take answer chips out of pringles
                
            }
        }
        
        printSudokuGrid()
        
        
        // - - - - run the code a fourth time
        
        for rowIndex in 0..<numberOfRows {
            for columnIndex in 0..<numberOfColumns {
                
                var cell = sudokuGrid[rowIndex][columnIndex]
                
                // - - - - - - - scans horizontally
                
                var answersFoundInRow: [Int] = []
                
                // scan for other answers in the current row
                for currentColumnInScan in 0..<numberOfColumns {
                    
                    let iteratedCan = sudokuGrid[rowIndex][currentColumnInScan]
                    
                    if isThisCellAnAnswer(withRow: rowIndex, andColumn: currentColumnInScan) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[rowIndex][currentColumnInScan]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInRow.append(foundAnswer)
                        
                        // remove the number from anything that scans it
                        // any box that scans this cell, removes it from its own can
                    } else {
                        // do nothing
                    }
                }
                
                print(answersFoundInRow)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInRow, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                
                // - - - - - - - - - - scan vertically
                
                var answersFoundInColumn: [Int] = []
                
                // scan for other answers in the current column
                for currentRowInScan in 0..<numberOfRows {
                    
                    let iteratedCan = sudokuGrid[currentRowInScan][columnIndex]
                    
                    if isThisCellAnAnswer(withRow: currentRowInScan, andColumn: columnIndex) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[currentRowInScan][columnIndex]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInColumn.append(foundAnswer)
                    }
                }
                
                print(answersFoundInColumn)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInColumn, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                // - - - - - - - - - -  scan the block
                
                //Sets up blocks for block scans
                let blockOne = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
                let blockTwo = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
                let blockThree = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]
                
                let blockFour = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
                let blockFive = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
                let blockSix = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]
                
                let blockSeven = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
                let blockEight = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
                let blockNine = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]
                
                let blocks = [blockOne,
                              blockTwo,
                              blockThree,
                              blockFour,
                              blockFive,
                              blockSix,
                              blockSeven,
                              blockEight]
                
                for iteratedBlock in blocks {
                    
                    // if current cell is in block one
                    if isCellInBlock(withCoords: iteratedBlock, andRow: rowIndex, andColumn: columnIndex) {
                        
                        for coordinates in iteratedBlock {
                            
                            var answersFoundInInteratedBlock: [Int] = []
                            
                            for currentIndexOfIteratedBlock in 0..<iteratedBlock.count {
                                let iteratedCan = sudokuGrid[currentIndexOfIteratedBlock]
                                
                                if let iteratedRow = iteratedBlock[currentIndexOfIteratedBlock].first, let iteratedColumn = iteratedBlock[currentIndexOfIteratedBlock].last {
                                    if isThisCellAnAnswer(withRow: iteratedRow, andColumn: iteratedColumn) {
                                        // take the number out of the pringles can
                                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[iteratedRow][iteratedColumn]
                                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                                        answersFoundInInteratedBlock.append(foundAnswer)
                                        print(foundAnswer)
                                    }
                                }
                            }
                            
                            print(answersFoundInInteratedBlock)
                            
                            cell = takeAnswersOutOfCell(withAnswers: answersFoundInInteratedBlock, andCell: sudokuGrid[rowIndex][columnIndex])
                            
                            // set the data after having removed all found horizontal numbers already  the row
                            sudokuGrid[rowIndex][columnIndex] = cell
                            print(coordinates)
                        }
                    }
                }
                
                // if index is identified in blockOne,
                // scan all indices in blockOne
                
                // else if this cell exists in blockTwo
                // scan block two
                
                // scan block for answers
                // take answer chips out of pringles
                
            }
        }
        
        printSudokuGrid()
        
        
        // - - -  run the code a sixth time
        
        for rowIndex in 0..<numberOfRows {
            for columnIndex in 0..<numberOfColumns {
                
                var cell = sudokuGrid[rowIndex][columnIndex]
                
                // - - - - - - - scans horizontally
                
                var answersFoundInRow: [Int] = []
                
                // scan for other answers in the current row
                for currentColumnInScan in 0..<numberOfColumns {
                    
                    let iteratedCan = sudokuGrid[rowIndex][currentColumnInScan]
                    
                    if isThisCellAnAnswer(withRow: rowIndex, andColumn: currentColumnInScan) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[rowIndex][currentColumnInScan]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInRow.append(foundAnswer)
                        
                        // remove the number from anything that scans it
                        // any box that scans this cell, removes it from its own can
                    } else {
                        // do nothing
                    }
                }
                
                print(answersFoundInRow)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInRow, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                
                // - - - - - - - - - - scan vertically
                
                var answersFoundInColumn: [Int] = []
                
                // scan for other answers in the current column
                for currentRowInScan in 0..<numberOfRows {
                    
                    let iteratedCan = sudokuGrid[currentRowInScan][columnIndex]
                    
                    if isThisCellAnAnswer(withRow: currentRowInScan, andColumn: columnIndex) {
                        // take the number out of the pringles can
                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[currentRowInScan][columnIndex]
                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                        answersFoundInColumn.append(foundAnswer)
                    }
                }
                
                print(answersFoundInColumn)
                
                cell = takeAnswersOutOfCell(withAnswers: answersFoundInColumn, andCell: sudokuGrid[rowIndex][columnIndex])
                
                // set the data after having removed all found horizontal numbers already  the row
                sudokuGrid[rowIndex][columnIndex] = cell
                
                // - - - - - - - - - -  scan the block
                
                //Sets up blocks for block scans
                let blockOne = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]]
                let blockTwo = [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]]
                let blockThree = [[0,6],[0,7],[0,8],[1,6],[1,7],[1,8],[2,6],[2,7],[2,8]]
                
                let blockFour = [[3,0],[3,1],[3,2],[4,0],[4,1],[4,2],[5,0],[5,1],[5,2]]
                let blockFive = [[3,3],[3,4],[3,5],[4,3],[4,4],[4,5],[5,3],[5,4],[5,5]]
                let blockSix = [[3,6],[3,7],[3,8],[4,6],[4,7],[4,8],[5,6],[5,7],[5,8]]
                
                let blockSeven = [[6,0],[6,1],[6,2],[7,0],[7,1],[7,2],[8,0],[8,1],[8,2]]
                let blockEight = [[6,3],[6,4],[6,5],[7,3],[7,4],[7,5],[8,3],[8,4],[8,5]]
                let blockNine = [[6,6],[6,7],[6,8],[7,6],[7,7],[7,8],[8,6],[8,7],[8,8]]
                
                let blocks = [blockOne,
                              blockTwo,
                              blockThree,
                              blockFour,
                              blockFive,
                              blockSix,
                              blockSeven,
                              blockEight]
                
                for iteratedBlock in blocks {
                    
                    // if current cell is in block one
                    if isCellInBlock(withCoords: iteratedBlock, andRow: rowIndex, andColumn: columnIndex) {
                        
                        for coordinates in iteratedBlock {
                            
                            var answersFoundInInteratedBlock: [Int] = []
                            
                            for currentIndexOfIteratedBlock in 0..<iteratedBlock.count {
                                let iteratedCan = sudokuGrid[currentIndexOfIteratedBlock]
                                
                                if let iteratedRow = iteratedBlock[currentIndexOfIteratedBlock].first, let iteratedColumn = iteratedBlock[currentIndexOfIteratedBlock].last {
                                    if isThisCellAnAnswer(withRow: iteratedRow, andColumn: iteratedColumn) {
                                        // take the number out of the pringles can
                                        let cellCurrentlyBeingCheckedForAnswers = sudokuGrid[iteratedRow][iteratedColumn]
                                        let foundAnswer = cellCurrentlyBeingCheckedForAnswers[0]
                                        answersFoundInInteratedBlock.append(foundAnswer)
                                        print(foundAnswer)
                                    }
                                }
                            }
                            
                            print(answersFoundInInteratedBlock)
                            
                            cell = takeAnswersOutOfCell(withAnswers: answersFoundInInteratedBlock, andCell: sudokuGrid[rowIndex][columnIndex])
                            
                            // set the data after having removed all found horizontal numbers already  the row
                            sudokuGrid[rowIndex][columnIndex] = cell
                            print(coordinates)
                        }
                    }
                }
                
                // if index is identified in blockOne,
                // scan all indices in blockOne
                
                // else if this cell exists in blockTwo
                // scan block two
                
                // scan block for answers
                // take answer chips out of pringles
                
            }
        }

        // end condition: all the cans have only one pringle
    }
    
    func isCellInBlock(withCoords inputCoords: [[Int]], andRow inputRow: Int, andColumn inputColumn: Int) -> Bool {
        
        var returnBool = false
        let inputCoord = [inputRow,inputColumn]
        for coord in inputCoords {
            if coord == inputCoord {
                returnBool = true
            }
        }
        return returnBool
    }
    
    func takeAnswersOutOfCell(withAnswers inputAnswers: [Int], andCell inputCell: [Int]) -> [Int] {
        var returnCell: [Int] = []
        returnCell = inputCell
        
        if inputCell.count > 1 {
            for answer in inputAnswers {
                
                //1. Get the index of the answer if it exists in the inputCell
                if let indexOfAnswer = returnCell.index(of: answer) {
                    //2. Remove the element at index of the answer
                    returnCell.remove(at: indexOfAnswer)
                    print("removed chip from can")
                }
            }
        }
        if returnCell.count <= 0 {
            print("something's wrong")
        }
        return returnCell
    }
    
    //Scan a can, if only has one chip in it
    func isThisCellAnAnswer(withRow inputRow: Int, andColumn inputColumn: Int) -> Bool {
        let cell = sudokuGrid[inputRow][inputColumn]
        let numberOfChipsInCell = cell.count
        if numberOfChipsInCell == 1 {
            return true
        } else {
            return false
        }
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
    
    
    
    //Sets a timer to update the latest data for the Sudoku puzzle every second
    func startOneSecondTimer() {
        oneSecondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(printSudokuGrid), userInfo: nil, repeats: true);
    }
    
//    func formatTextView() {
//
//        // Set the monospaced font
//        guard let monoSpacedFont = UIFont(name: "Neon Pixel-7", size: 66) else {
//            return
//        }
//        textView.font = monoSpacedFont
//
//        // Determine the width/height difference
//        let fontSize = sizeOfString(string: "1", font: monoSpacedFont)
//        let difference = fontSize.height - fontSize.width
//
//        // Add kerning to a new attributed string
//        var adjustedString = NSMutableAttributedString(string: textView.text)
//
//        print("height: \(adjustedString.height(withConstrainedWidth: 0.0))")
//        print("width: \(adjustedString.width(withConstrainedHeight: 0.0))")
//
//        let stringRange = NSMakeRange(0, adjustedString.length)
//        adjustedString.addAttribute(NSAttributedStringKey.font, value: monoSpacedFont, range: stringRange)
//        adjustedString.addAttribute(NSAttributedStringKey.kern, value: difference, range: stringRange)
//        adjustedString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.cyan, range: stringRange)
//        textView.attributedText = adjustedString
//    }
    
//    func sizeOfString(string:String, font:UIFont) -> CGSize {
//        let fontAttributes = [NSAttributedStringKey.font: font]
//        let size = string.size(withAttributes: fontAttributes)
//        return size
//    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
