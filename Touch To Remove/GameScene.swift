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
    //its better not to make this var in didmove because it will not be eaily cleared.
//    var playButton: BDButton = {
//       // var button = BDButton(imageNamed: "ButtonPlay", buttonAction: {
//           // ACTManager.shared.transition(self, toScene: .EndMenuVC, transition:
//              //  SKTransition.moveIn(with: .right, duration: 0.5))
//        //})
//        //button.zPosition = 1
//        return button
//    }()
    var starfield:SKEmitterNode!
    var alien = SKSpriteNode()
    var alien2 = SKSpriteNode()
    var alien2Valid = Bool()
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    var youWinLabel = SKLabelNode()
    var timerLabel = SKLabelNode()
    var viewController: EndMenuVC!
    var level:Int = 1
    var game = false
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
        scoreLabel.position = CGPoint(x: -370, y: 170)
        timerLabel.position = CGPoint(x: 120, y: 170)
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        youWinLabel.position = CGPoint(x: 0, y: 0)
        self.addChild(scoreLabel)
        self.addChild(timerLabel)
        self.addChild(gameOverLabel)
        self.addChild(youWinLabel)
        //--no longer needed. we are going wtih the new aproach
        //add button
        //addPlayButton()
        startGame()
    }
    
    func startGame(){
        alien.position = CGPoint(x: -600, y: 0)
        alien.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
        addChild(alien)
        alien2Valid = false
        startTimer()
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

            if location.y < alien.position.y + 20 && location.y > alien.position.y - 20 && location.x < alien.position.x + 20 && location.x > alien.position.x - 20 {
                alien.removeFromParent()
                alien.position = CGPoint(x: xN, y: yN)
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
            //------no longer needed. using the new approach
            //enumerate for new button
//            enumerateChildNodes(withName: "//*", using: { (node, stop) in
//                if node.name == "playButton" {
//                    if node.contains(touch.location(in: self)) {
//                        print("cliked the button")
//                    }
//
//                }
//            })
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
               }
    }
    //------no longer needed. using the new approach
//    func addPlayButton() {
//        let playButton = SKSpriteNode(imageNamed: "ButtonPlay")
//        playButton.name = "playButton"
//        playButton.position = CGPoint.zero
//        addChild(playButton)
//    }
    
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
