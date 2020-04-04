//
//  GameViewController.swift
//  Pong4
//
//  Created by Behrooz Falsafi on 3/1/20.
//  Copyright © 2020 Behrooz Falsafi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//setup currentGameType variable here so we can pass it alone from menuVC to GameScene.swift

class EndMenuVC: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //create a view
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //Grabbing the boundaries of our scene project and applying it to our scene that we created right above
                scene.size = view.bounds.size
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func moveToEndMenuVC () {
        performSegue(withIdentifier: "name", sender: self)
    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
