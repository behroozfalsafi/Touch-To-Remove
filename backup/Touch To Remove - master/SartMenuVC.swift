//
//  menuVC.swift
//  Pong4
//
//  Created by Behrooz Falsafi on 3/1/20.
//  Copyright © 2020 Behrooz Falsafi. All rights reserved.
//

import Foundation
import UIKit

//create an enum so we can work with certain game type
enum gameType{
    case easy
    case medium
    case hard
    case player2
}
//create a view controler class so we can directly impact the view controler that we have created
class SartMenuVC : UIViewController {
    
    @IBAction func player2(_ sender: Any) {
        moveToGame(game: .player2)
    }
    
    @IBAction func easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    //create a function so when we click any of the button it will take us to game view controler
    func moveToGame(game : gameType){
        //reference the gameviewcontroler by using gameVC
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        //now move to game view controler by using the navaigation controler and set currentGameType of gameviewcontroler to game from this file
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}


