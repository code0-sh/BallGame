//
//  GameScene.swift
//  BallGame
//
//  Created by omura.522 on 2015/07/24.
//  Copyright (c) 2015年 fssoftware. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // 地面のスプライト
    var floorSprite = SKSpriteNode()
    
    func initObjects(){
        // ボール
        let radius:CGFloat = 20
        let shape = SKShapeNode(circleOfRadius:radius)
        shape.fillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        //ランダムに配置
        var randIntX = radius + (CGFloat)(arc4random_uniform((UInt32)(self.frame.width-radius*2)))
        var randIntY = radius + (CGFloat)(arc4random_uniform((UInt32)(self.frame.height-radius*2)))
        shape.position = CGPoint(x:randIntX, y:randIntY)
        self.addChild(shape)
        // 重力
        shape.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        shape.physicsBody?.restitution = 1.0 // 反発係数
        shape.physicsBody?.linearDamping = 0.0 // 空気抵抗
        shape.physicsBody?.mass = 1.0 // 質量
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("衝突")
    }
    
    override func didMoveToView(view: SKView) {
        initObjects()
        // 重力
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
