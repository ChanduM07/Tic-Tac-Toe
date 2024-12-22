//
//  ViewController.swift
//  TickTackGame
//
//  Created by Chandan Mondal on 21/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Nought
        case Cross
    }
    
    
    @IBOutlet weak var turnLabel: UILabel!{
        didSet { turnLabel.textColor = .systemBlue }
    }

    @IBOutlet weak var btnA1: UIButton!
    @IBOutlet weak var btnA2: UIButton!
    @IBOutlet weak var btnA3: UIButton!
    
    @IBOutlet weak var btnB1: UIButton!
    @IBOutlet weak var btnB2: UIButton!
    @IBOutlet weak var btnB3: UIButton!
    
    @IBOutlet weak var btnC1: UIButton!
    @IBOutlet weak var btnC2: UIButton!
    @IBOutlet weak var btnC3: UIButton!

    var firstTurn = Turn.Cross
    var curretTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var norghtsScore: Int = 0
    var crossesScore: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }

    private func initBoard(){
        board.append(btnA1)
        board.append(btnA2)
        board.append(btnA3)
        
        board.append(btnB1)
        board.append(btnB2)
        board.append(btnB3)
        
        board.append(btnC1)
        board.append(btnC2)
        board.append(btnC3)
    }
    
    @IBAction func btnTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
        }
        
        if checkForVictory(NOUGHT) {
            norghtsScore += 1
            resultAlert(title: "Noughts Win!")
        }
        
        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    private func checkForVictory(_ s: String) -> Bool {
        
        //MARK: Horizontal Victory....
        if thisSimbol(btnA1, s) && thisSimbol(btnA2, s) && thisSimbol(btnA3, s) {
            return true
        }
        if thisSimbol(btnB1, s) && thisSimbol(btnB2, s) && thisSimbol(btnB3, s) {
            return true
        }
        if thisSimbol(btnC1, s) && thisSimbol(btnC2, s) && thisSimbol(btnC3, s) {
            return true
        }
        
        
        //MARK: Vertical Victory....
        if thisSimbol(btnA1, s) && thisSimbol(btnB1, s) && thisSimbol(btnC1, s) {
            return true
        }
        if thisSimbol(btnA2, s) && thisSimbol(btnB2, s) && thisSimbol(btnC2, s) {
            return true
        }
        if thisSimbol(btnA3, s) && thisSimbol(btnB3, s) && thisSimbol(btnC3, s) {
            return true
        }
        
        
        //MARK: Digonal Victory....
        if thisSimbol(btnA1, s) && thisSimbol(btnB2, s) && thisSimbol(btnC3, s) {
            return true
        }
        if thisSimbol(btnA3, s) && thisSimbol(btnB2, s) && thisSimbol(btnC1, s) {
            return true
        }
        
        return false
    }
    
    private func thisSimbol(_ button: UIButton, _ symbol: String) -> Bool {
        
        return button.title(for: .normal) == symbol
    }
    
    
    private func resultAlert(title: String){
        let message = "\nNoughts " + String(norghtsScore) + "\n\nCrosses " + String(crossesScore)
        let actionSh = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionSh.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            self.resetBoard()
        }))
        self.present(actionSh, animated: true)
    }
    
    private func resetBoard(){
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
            turnLabel.textColor = .systemBlue
        } else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
            turnLabel.textColor = .systemOrange
        }
        curretTurn = firstTurn
    }
    
    
    private func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    
    private func addToBoard(_ sender: UIButton){
        if(sender.title(for: .normal) == nil){
            if curretTurn == Turn.Nought {
                sender.setTitle(NOUGHT, for: .normal)
                sender.setTitleColor(.systemOrange, for: .normal)
                turnLabel.textColor = .systemBlue
                curretTurn = Turn.Cross
                turnLabel.text = CROSS
            } else if curretTurn == Turn.Cross {
                sender.setTitle(CROSS, for: .normal)
                sender.setTitleColor(.systemBlue, for: .normal)
                turnLabel.textColor = .systemOrange
                curretTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
        
    }
}

