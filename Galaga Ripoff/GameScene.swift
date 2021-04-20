//
//  GameScene.swift
//  Galaga Ripoff
//
//  Created by Student on 4/14/21.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
var paddle = SKSpriteNode()
    
    var enemy = SKSpriteNode()
    override func didMove(to view: SKView) {
        createBackground()
        makePaddle()
        
        makeEnemy()
    }
    func createBackground() {
        let stars = SKTexture(imageNamed: "Stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(moveForever)
        }
    }
    func makePaddle() {
        paddle.removeFromParent()   // remove the paddle, if it exists
        paddle = SKSpriteNode(imageNamed: "F-22 Raptor")
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        paddle.name = "paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    
    func makeEnemy() {
        enemy.removeFromParent()
        enemy = SKSpriteNode(imageNamed:"Enemy fighter")
        enemy.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        enemy.name = "Enemy"
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        enemy.physicsBody?.friction = 0
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.restitution = 1
        enemy.physicsBody?.linearDamping = 0
        enemy.physicsBody?.contactTestBitMask = (enemy.physicsBody?.collisionBitMask)!
        addChild(enemy)
    }

}

