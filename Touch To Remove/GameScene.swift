//
//  GameScene.swift
//  Touch To Remove
//
//  Created by Behrooz Falsafi on 3/23/20.
//  Copyright © 2020 Behrooz Falsafi. All rights reserved.
//---------------new branch

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var starfield:SKEmitterNode!
    var alien = SKSpriteNode()
    var alien2 = SKSpriteNode()
    var alien2Valid = Bool()
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    var youWinLabel = SKLabelNode()
    var timerLabel = SKLabelNode()
    var viewController: EndMenuVC!
     var timer : Timer? = nil {
           willSet {
               timer?.invalidate()
           }
       }
    var timeCounter:Int = 5 {
        didSet {
            timerLabel.text = "Timer: \(timeCounter)"
        }
    }
    
    var level:Int = 1
    var game = false
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        //give positon of to startfield file(emitter)
        starfield.position = CGPoint(x: -600 , y: 0) //1334
        //delay it so it start at the right time
        starfield.advanceSimulationTime(10)
        //rotate
        //starfield.zRotation = .pi / 4
        //to see it on screen
        self.addChild(starfield)
        //run starfield behind everything eles
        starfield.zPosition = -1
        
        
        

        alien = SKSpriteNode(imageNamed: "alien")
        alien2 = SKSpriteNode(imageNamed: "alien2")
        scoreLabel.text = "Score: 0"
        timerLabel.text = "Timer: 5"
        alien.color = .blue
        alien.physicsBody = SKPhysicsBody(circleOfRadius: alien.size.height)
        alien2.physicsBody = SKPhysicsBody(circleOfRadius: alien2.size.height)
        alien.physicsBody?.affectedByGravity = false
        alien2.physicsBody?.affectedByGravity = false
        scoreLabel.position = CGPoint(x: -350, y: 130)
        timerLabel.position = CGPoint(x: 70, y: 130)
        gameOverLabel.position = CGPoint(x: 50, y: 0)
        youWinLabel.position = CGPoint(x: 50, y: 0)
        self.addChild(scoreLabel)
        self.addChild(timerLabel)
        self.addChild(gameOverLabel)
        self.addChild(youWinLabel)
        startGame()
        
    }
    
    func startGame(){

        alien.position = CGPoint(x: -600, y: 0)
        alien.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
        addChild(alien)
        alien2Valid = false
        startTimer()
       // gameTimer = Timer.scheduledTimer(timeInterval: 1.75, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
    }
    

    
    func createAlien(){
        let randomY = GKRandomDistribution(lowestValue: Int(-self.frame.size.width / 2 + 100) , highestValue: Int(self.frame.size.width / 2 - 100))
        let randomX = GKRandomDistribution(lowestValue: Int(-self.frame.size.height / 2  + alien2.size.height), highestValue: Int(self.frame.size.height / 2  - alien2.size.height))
        let xN = CGFloat(randomX .nextInt())
        let yN = CGFloat(randomY .nextInt())
        alien2.position = CGPoint(x: -350, y: 100)
        alien2.physicsBody?.velocity = CGVector(dx: 200, dy: 0)

            addChild(alien2)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if alien2Valid == false && timeCounter == level {
           createAlien()
            alien2Valid = true
        }
        
        let randomX = GKRandomDistribution(lowestValue: Int(-self.frame.size.width / 2 + 100) , highestValue: Int(self.frame.size.width / 2 - 100))
        let randomY = GKRandomDistribution(lowestValue: Int(-self.frame.size.height / 2  + alien.size.height), highestValue: Int(self.frame.size.height / 2  - alien.size.height))
        for touch in touches{
            let location = touch.location(in: self)
            let xN = CGFloat(randomX .nextInt())
            let yN = CGFloat(randomY .nextInt())
            //print(location, xN, yN) //Debugging

            if location.y < alien.position.y + 20 && location.y > alien.position.y - 20 && location.x < alien.position.x + 20 && location.x > alien.position.x - 20 {
                alien.removeFromParent()
                alien.position = CGPoint(x: xN, y: yN)
                //print(location, xN, yN) //Debugging
                score += 1
                timeCounter = 5
                addChild(alien)
                if score == 6 {
                    print("YOU WIN")
                    youWinLabel.text = "YOU WIN"
                    alien.position = CGPoint(x: -350, y: 120)
                    score = 0
                    timeCounter = 5
                    stopTimer()
                }
            }
            
            else if location.y < alien2.position.y + 20 && location.y > alien2.position.y - 20 && location.x < alien2.position.x + 20 && location.x > alien2.position.x - 20 {
                alien2.removeFromParent()
                alien2.position = CGPoint(x: xN, y: yN)
                //print(location, xN, yN) //Debugging
                score += 1
                timeCounter = 5
                addChild(alien2)
                if score == 6 {
                    print("YOU WIN")
                    youWinLabel.text = "YOU WIN"
                    alien2.position = CGPoint(x: -350, y: 80)
                    score = 0
                    timeCounter = 5
                    stopTimer()
                }
            }
        }
   
    }
    @objc func startGameTimer (){
        timeCounter -= 1
        print(timeCounter)

    }
    func startTimer() {
        stopTimer()
        guard self.timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }

    func gameOver () {
        if timeCounter == 0 {
                print("GAME OVER")
                gameOverLabel.text = "GAME OVER"
                alien.position = CGPoint(x: -350, y: 20)
                score = 0
                timeCounter = 5
                stopTimer()
            //tempVC.performSegue(withIdentifier: "name", sender: self)
             
                   
               }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //move enemy level back and forth depending on the diffialty of the game.
        switch currentGameType {
        case .easy:
            level = 2
            break
        case .medium:
            level = 3
            break
        case .hard:
            level = 4
            break
        case .player2:
            
            break
        }
        
        if alien2Valid == false && timeCounter == level {
            createAlien()
            alien2Valid = true
        }
        gameOver ()
       
    }
}
