//
//  MainViewController.swift
//  Pongster
//
//  Created by Vlad on 11/20/17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import Foundation


enum gameType{
    case easy
    case medium
    case hard
    case insane
    case player2
}

class MainViewController: UIViewController {
    
    
    @IBAction func Easy(_ sender: UIButton) {
        moveToGame(game: .easy)
        
    }
    
    
    @IBAction func Medium(_ sender: UIButton) {
        moveToGame(game: .medium)
    }
    
    @IBAction func Hard(_ sender: UIButton) {
        moveToGame(game: .hard)
    }
    
    @IBAction func Insane(_ sender: UIButton) {
        moveToGame(game: .insane)
    }
    

    @IBAction func Player2(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    
    
    func moveToGame(game: gameType){
        let gameVC=self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        //gametype is equal to the game they clicked on
        currentGameType=game
        
        
        
        self.navigationController?.pushViewController(gameVC, animated: true)
        
        
    }
    
    
}
