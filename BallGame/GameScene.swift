//
//  GameScene.swift
//  BallGame
//
//  Created by omura.522 on 2015/07/24.
//  Copyright (c) 2015年 fssoftware. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    func initObjects(){
        // ボール
        for i in 0..<10 {
            var radius: CGFloat = 20
            var ball = SKShapeNode(circleOfRadius:radius)
            ball.fillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            // ランダムに配置
            var randIntX = radius + (CGFloat)(arc4random_uniform((UInt32)(self.frame.width-radius*2)))
            var randIntY = radius + (CGFloat)(arc4random_uniform((UInt32)(self.frame.height-radius*2)))
            ball.position = CGPoint(x:randIntX, y:randIntY)
            self.addChild(ball)
            // 重力
            ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            ball.physicsBody?.restitution = 1.0 // 反発係数
            ball.physicsBody?.linearDamping = 0.0 // 空気抵抗
            ball.physicsBody?.mass = 1.0 // 質量
            ball.physicsBody?.friction = 0.0 // 摩擦
            ball.physicsBody?.contactTestBitMask = 1
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if let nodeA = contact.bodyA.node {
            if let nodeB = contact.bodyB.node {
                if nodeA.name == "frame" || nodeB.name == "frame" {
                    // 壁との衝突
                    return
                }else {
                    // ボール同士の衝突
                    // パーティクル生成
                    let particle = SKEmitterNode(fileNamed: "ConflictParticle.sks")
                    self.addChild(particle)

                    // ぶつかるたびにパーティクルが増えて処理が重くなるため
                    // パーティクルを表示してから1秒後に削除する
                    var removeAction = SKAction.removeFromParent()
                    var durationAction = SKAction.waitForDuration(1)
                    var sequenceAction = SKAction.sequence([durationAction, removeAction])
                    particle.runAction(sequenceAction)
                
                    // ボールの位置にパーティクルを移動
                    particle.position = CGPoint(x: nodeA.position.x, y: nodeA.position.y)
                    particle.alpha = 1
                
                    var fadeAction = SKAction.fadeAlphaBy(0, duration: 0.5)
                    particle.runAction(fadeAction)
                }
            }
        }
    }
    
    override func didMoveToView(view: SKView) {
        initObjects()
        // 重力
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.physicsBody?.restitution = 1.0 // 反発係数
        self.physicsBody?.linearDamping = 0.0 // 空気抵抗
        self.physicsBody?.friction = 0.0 // 摩擦
        self.name = "frame"
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
