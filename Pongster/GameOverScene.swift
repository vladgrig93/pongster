//
//  GameOver.swift
//  Pongster
//
//  Created by Vlad on 11/21/17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        let path = Bundle.main.path(forResource: "LoseParticle", ofType: "sks")
        let loseParticle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        
        loseParticle.position=CGPoint(x: 105, y: 55)
        loseParticle.name = "rainParticle"
        loseParticle.targetNode = self.scene
        
        self.addChild(loseParticle)
    }

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
        let location = touch.location(in:self);
        if atPoint(location).name == "play" {
            if let scene = GameScene(fileNamed: "GameScene" ){
                scene.scaleMode = .aspectFill
                view!.presentScene(scene, transition:SKTransition.push(with:.up, duration: 0.4))
            }
        }
    }
    
}
}
