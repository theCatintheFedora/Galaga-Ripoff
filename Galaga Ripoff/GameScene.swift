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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                    let location = touch.location(in: self)
                    paddle.position.x = location.x
                }
       }
       override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                    let location = touch.location(in: self)
                    paddle.position.x = location.x
                }
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
        paddle.removeFromParent()
        paddle = SKSpriteNode(imageNamed: "F-22 Raptor")
        paddle.setScale(0.3)
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        paddle.name = "Fighter"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    func makeEnemy() {
        enemy.removeFromParent()
        enemy = SKSpriteNode(imageNamed:"Enemy fighter")
        enemy.setScale(0.1)
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


