//
//  GameScene.swift
//  SpaceJump
//
//  Created by Catherine Smith on 1/2/19.
//  Copyright © 2019 Jacob Smith. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var flyingCar: SKSpriteNode!
    var groundBit: UInt32 = 1
    var carBit: UInt32 = 0
    
    override func didMove(to view: SKView) {
        
        setUpPhysics()
        setUpScenery()
        setUpFlyingCar()
        
    }
    
    fileprivate func setUpPhysics() {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.speed = 1.0
    }
    
    fileprivate func setUpScenery() {
        
        let background = SKSpriteNode(imageNamed: ImageName.Background)
        //background.anchorPoint = CGPoint(x: 1334, y: 750)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.Background
        background.size = CGSize(width: size.width, height: size.height)
        addChild(background)
        
        let ground = SKSpriteNode(imageNamed: ImageName.Ground)
        //ground.anchorPoint = CGPoint(x: 1334, y: 750)
        ground.position = CGPoint(x: 0, y: -375)
        ground.zPosition = Layer.Ground
        //ground.size = CGSize(width: size.width, height: size.height * 0.2139)
        ground.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: ImageName.Ground), size: ground.size)
        ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        ground.physicsBody?.collisionBitMask = 1
        groundBit = ground.physicsBody!.collisionBitMask
        ground.physicsBody?.density = 0.5
        ground.physicsBody?.isDynamic = false
        addChild(ground)
        
        
    }
    
    fileprivate func setUpFlyingCar() {
        
        flyingCar = SKSpriteNode(imageNamed: ImageName.FlyingCarSit)
        flyingCar.position = CGPoint(x: 0, y: 0)
        flyingCar.zPosition = Layer.FlyingCar
        flyingCar.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: ImageName.FlyingCarSit), size: flyingCar.size)
        flyingCar.physicsBody?.categoryBitMask = PhysicsCategory.FlyingCar
        flyingCar.physicsBody?.collisionBitMask = 0
        carBit = flyingCar.physicsBody!.collisionBitMask
        flyingCar.physicsBody?.contactTestBitMask = PhysicsCategory.Ground
        flyingCar.physicsBody?.isDynamic = true
        
        addChild(flyingCar)
        
    }
    
    fileprivate func animateFlyingCarFly() {
        //let duration = 2.0 + drand48() * 2.0
        let fly = SKAction.setTexture(SKTexture(imageNamed: ImageName.FlyingCarFly))
//        let wait = SKAction.wait(forDuration: duration)
//        let close = SKAction.setTexture(SKTexture(imageNamed: ImageName.CrocMouthClosed))
        let sequence = SKAction.sequence([fly])
        
        flyingCar.run(SKAction.repeatForever(sequence))
        
    }
    
    fileprivate func animateFlyingCarSit() {
        //let duration = 2.0 + drand48() * 2.0
        let sit = SKAction.setTexture(SKTexture(imageNamed: ImageName.FlyingCarSit))
        //        let wait = SKAction.wait(forDuration: duration)
        //        let close = SKAction.setTexture(SKTexture(imageNamed: ImageName.CrocMouthClosed))
        let sequence = SKAction.sequence([sit])
        
        flyingCar.run(SKAction.repeatForever(sequence))
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        animateFlyingCarFly()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        animateFlyingCarSit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.bodyB.collisionBitMask == carBit)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
