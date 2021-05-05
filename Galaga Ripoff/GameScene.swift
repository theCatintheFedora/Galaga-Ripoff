//
//  GameScene.swift
//  Galaga Ripoff
//
//  Created by Student on 4/14/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var paddle = SKSpriteNode()
    var enemies = [SKSpriteNode]()
    var playLabel = SKLabelNode()
    var livesLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var playingGame = false
    var score = 0
    var lives = 3
    var count0 = 0
    var timer = Timer()
    var missiles = [SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createBackground()
        makePaddle()
        makeLabels()
        timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true, block: { (timer) in
            self.attackingFighter()
            self.ordinance()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if playingGame {
                paddle.position.x = location.x
            }
            else {
                for node in nodes(at: location) {
                    if node.name == "playLabel" {
                        playingGame = true
                        node.alpha = 0
                        score = 0
                        lives = 3
                        //updateLabels()
                        //fix this later
                        resetGame()
                    }
                }
            }
        }
        //guard let touch = touches.first else { return}
       // let location = touchlocation(in: self)
       // touchlocation = location
       // touchTime = CACurrentMediaTime()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
       // let touchTimeThreshold: CFTimeInterval = 0.3
        //let touchDistanceThreshold: CGFloat = 4
     //   guard CACurrentMediaTime() - touchTime < touchTimeThreshold, ordinance.isHidden,
              //let touch = touches.first else { return}
       // let location = touch.location(in: self)
        
       // guard swipelength > touchDistanceThreshold else {return}
        // TODO
    }
    
    func resetGame() {
        makePaddle()
    }
    
    func attackingFighter() {
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
        let enemy = SKSpriteNode(imageNamed:"Enemy fighter")
        enemy.setScale(0.1)
        enemy.position = CGPoint(x: Int.random(in: -5...5), y: Int(frame.maxY) - 10)
        enemy.name = "Enemy"
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height)
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        enemy.physicsBody?.friction = 0
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.restitution = 1
        enemy.physicsBody?.linearDamping = 0
        enemy.physicsBody?.contactTestBitMask = (enemy.physicsBody?.collisionBitMask)!
        addChild(enemy)
        enemies.append(enemy)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.applyImpulse(CGVector(dx: Int.random(in: -5...5), dy: -5))
    }
    
    func makeLabels() {
        playLabel.fontSize = 24
        playLabel.text = "Tap to start"
        playLabel.fontName = "Arial"
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        playLabel.name = "playLabel"
        addChild(playLabel)
        
        livesLabel.fontSize = 18
        livesLabel.fontColor = .black
        livesLabel.position = CGPoint(x: frame.minX + 50, y: frame.minY + 18)
        addChild(livesLabel)
        
        scoreLabel.fontSize = 18
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "Arial"
        scoreLabel.position = CGPoint(x: frame.maxX - 50, y: frame.minY + 18)
        addChild(scoreLabel)
    }
    
    func ordinance() {
        let ordinance = SKSpriteNode(imageNamed:"Ordinance")
        ordinance.name = "Ordinance"
        ordinance.setScale(0.15)
        ordinance.position = paddle.position
        ordinance.physicsBody = SKPhysicsBody(circleOfRadius: ordinance.size.height/2)
        ordinance.physicsBody?.isDynamic = false
        ordinance.physicsBody?.usesPreciseCollisionDetection = true
        ordinance.physicsBody?.friction = 0
        ordinance.physicsBody?.affectedByGravity = false
        ordinance.physicsBody?.restitution = 1
        ordinance.physicsBody?.linearDamping = 0
        ordinance.physicsBody?.contactTestBitMask = (ordinance.physicsBody?.collisionBitMask)!
        addChild(ordinance)
        missiles.append(ordinance)
        ordinance.physicsBody?.isDynamic = true
        ordinance.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
    }
}


