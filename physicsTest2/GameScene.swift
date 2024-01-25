//
//  GameScene.swift
//  physicsTest2
//
//  Created by Krish Bothra on 1/19/24.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    let terrain = SKShapeNode(rectOf: CGSize(width: 500, height: 30))
    
    var startTouch = CGPoint()
    var endTouch = CGPoint()
    var motionManager: CMMotionManager!
    
    
    var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }

    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    
    override func didMove(to view: SKView) {
        self.backgroundColor = .lightGray
            
            // Set the scale mode to .aspectFit
        self.scaleMode = .aspectFit
            
            // Create a physics body representing an edge loop from the scene's frame
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        resetGravityOfPhysicsWorldToZero()
        backgroundColor = .lightGray
        player = SKSpriteNode(imageNamed: "Marble")
        player.size = CGSize(width: 75, height: 75)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 14)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = true;
        player.position = .init(x:0, y:200)
        addChild(player)
        
        terrain.strokeColor = .black
        terrain.fillColor = .black
        terrain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 30))
        terrain.physicsBody?.affectedByGravity = false
        terrain.physicsBody?.isDynamic = false
        terrain.position = .init(x:0, y:0)
        
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        addChild(terrain)
        
    }
    
    
    func touchDown(_ touches: Set<UITouch>, with event: UIEvent) {
        
    }
    
    func touchMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        
    }
    
    func touchUp(_ touches: Set<UITouch>, with event: UIEvent) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            startTouch = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            endTouch = touch.location(in: self)
        }
        
        player.position = .init(x:0, y:200)
        resetGravityOfPhysicsWorldToZero()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
#if targetEnvironment(simulator)
    if let currentTouch = lastTouchPosition {
        let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
        physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
    }
#else
    if let accelerometerData = motionManager.accelerometerData {
        physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 7, dy: accelerometerData.acceleration.y * 0)
    }
#endif
        
       
    }
    
    func resetGravityOfPhysicsWorldToZero() {
        physicsWorld.gravity = .zero
    }
}
