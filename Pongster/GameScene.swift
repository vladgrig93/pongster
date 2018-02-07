//
//  GameScene.swift
//  Pongster
//
//  Created by Vlad on 11/20/17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import ImageIO

class GameScene: SKScene {
    
    var gameBackgroundMusic: AVAudioPlayer?
    
    //1.initializing variables as SKNodes, var names are the same as we named them in gamescene
    var ball=SKSpriteNode()
    var enemy=SKSpriteNode()
    var main=SKSpriteNode()
    
    var topLabel=SKLabelNode()
    var bottomLabel=SKLabelNode()
    
    
    var score=[Int]()
    
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        
        
        
        
        
        //calling startgame function for scores
        
        
        
        
        topLabel=self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel=self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        
        //2.from the view gets the children as spritenodes and sets them to the variables
        ball=self.childNode(withName: "ball" ) as! SKSpriteNode
        enemy=self.childNode(withName:"enemy")as! SKSpriteNode
        main=self.childNode(withName:"main")as! SKSpriteNode
        
    
        
        
        
        //4. adding the screen frame as the border
        let border=SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction=0
        //restitution to 1 creates bounciness from the borders
        border.restitution=1
        //setting border to the scene
        self.physicsBody=border
        
        
        
        startGame()
        
        
        
        
        
        
        
        
    }
    
    
    func startGame(){
        score=[0,0]
        
        
        
        //initiating the score labels
        topLabel.text="\(score[1])"
        bottomLabel.text="\(score[0])"
        
        
        do {
            
            gameBackgroundMusic=try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "music", ofType: "mp3")!))
            gameBackgroundMusic?.prepareToPlay()
            play()
            
        }
        catch{
            print(error)
        }
        
        
        
        //3. initializing ball's movement when game starts. keeping the directions the same creates a 45 degree angle which is what we want.
        if currentGameType == .insane{
            ball.physicsBody?.applyImpulse(CGVector(dx:-70,dy:-70))
        }
        else if currentGameType == .hard{
              ball.physicsBody?.applyImpulse(CGVector(dx:-40,dy:-40))
            }
        else{
        ball.physicsBody?.applyImpulse(CGVector(dx:-30,dy:-30))
        }
        
        
        
        
        
    }
    

    func addScore(playerWhoWon: SKSpriteNode){
        
        //resetting the position and removing all the impulses
        ball.position=CGPoint(x:0,y:0)
        ball.physicsBody?.velocity=CGVector(dx: 0, dy: 0)
        //
        if playerWhoWon==main{
            score[0]+=1
            //gives ball in directino of the main to enemy
            if currentGameType == .insane{
                ball.physicsBody?.applyImpulse(CGVector(dx:70,dy:70))
            }
            else if currentGameType == .hard || currentGameType == .player2{
                ball.physicsBody?.applyImpulse(CGVector(dx:40,dy:40))
            }
            else{
                ball.physicsBody?.applyImpulse(CGVector(dx:30,dy:30))
            }
            
    }
        else if playerWhoWon==enemy{
            score[1]+=1
            //gives ball in direction of enemy to main
            if currentGameType == .insane{
                ball.physicsBody?.applyImpulse(CGVector(dx:-70,dy:-70))
            }
            else if currentGameType == .hard || currentGameType == .player2 {
                ball.physicsBody?.applyImpulse(CGVector(dx:-40,dy:-40))
            }
            else{
                ball.physicsBody?.applyImpulse(CGVector(dx:-30,dy:-30))
            }
            
        }
        print(score)
        //showing the score labels
        topLabel.text="\(score[1])"
        bottomLabel.text="\(score[0])"
        

        if score[0]==3{
            
            self.victory()
        }
        if score[1]==5{
            self.gameOver()
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //grabs the points the user touches
        for touch in touches{
            let location=touch.location(in:self)
            //**Logic for 2 player
            if currentGameType == .player2{
                if location.y>0{
                    enemy.run(SKAction.moveTo(x:location.x, duration:0.1))
                }
                if location.y<0{
                    main.run(SKAction.moveTo(x:location.x, duration:0.1))
                }
            }
                //1 player logic
            else{
                //moves main paddle to that x location with a slight delay
                main.run(SKAction.moveTo(x:location.x, duration:0.1))
            }
            
        }
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
          //does same thing as began for when they drage the paddle
        for touch in touches {
            let location=touch.location(in:self)
            //**Logic for 2 player
            if currentGameType == .player2{
                if location.y>0{
                    enemy.run(SKAction.moveTo(x:location.x, duration:0.1))
                }
                if location.y<0{
                    main.run(SKAction.moveTo(x:location.x, duration:0.1))
                }
            }
                //1 player logic
            else{
            //moves main paddle to that x location with a slight delay
            main.run(SKAction.moveTo(x:location.x, duration:0.1))
        }

        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered, keep things to a minimum
        
        //for enemy-moves the enemy paddle to the x position of the ball, the less of duration the harder the enemy. enemy duration at 0 is impossible to win
        //setting switches with the game type to determine enemy movement
        switch currentGameType{
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration:0.4))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration:0.3))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration:0.1))
            main.size.width=100
            break
        case .insane:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration:0.065))
            main.size.width=100
//            main.run(SKAction.moveTo(x: ball.position.x, duration:0))
            break
        //no enemy movement for player2
        case .player2:
            break
        }
        
        
        
        
        //if the ball drops 70 below the players position or 70 above enemies, we add to their scores
        if ball.position.y<=main.position.y - 70{
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y>=enemy.position.y+70{
            addScore(playerWhoWon: main)
        }
        
    }
    
    func play(){
        gameBackgroundMusic?.play()
        
    }
    func victory(){
        if let scene = VictoryScene(fileNamed: "VictoryScene") {
            scene.scaleMode = .aspectFill
            
            view?.presentScene(scene, transition:SKTransition.doorway(withDuration: 0.5))
        }
    }
    
    func gameOver(){
//        gameBackgroundMusic?.stop()
        if let scene = GameOverScene(fileNamed: "GameOver") {
            
            scene.scaleMode = .aspectFill
            
            
            view?.presentScene(scene, transition:SKTransition.doorway(withDuration: 0.5))
        }
        
    }

}


