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
    override func didMove(to view: SKView) {
        createBackground()
        makePaddle()
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
        paddle = SKSpriteNode(imageNamed: “F-22 Raptor”)
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        paddle.name = "paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }

}
