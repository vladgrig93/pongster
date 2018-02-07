//
//  VictoryScene.swift
//  Pongster
//
//  Created by Vlad on 11/21/17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import SpriteKit

class VictoryScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        let path = Bundle.main.path(forResource: "WinParticle", ofType: "sks")
        let winParticle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        
        winParticle.position=CGPoint(x: 105, y: 55)
        winParticle.name = "WinParticle"
       winParticle.targetNode = self.scene
        
        self.addChild(winParticle)
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
