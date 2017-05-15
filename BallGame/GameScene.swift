//
//  GameScene.swift
//  BallGame
//
//  Created by omura.522 on 2015/07/24.
//  Copyright (c) 2015年 fssoftware. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // CMMotionManagerを格納する変数
    var motionManager: CMMotionManager!
    // ボールの色
    var ballColor: [CGFloat] = [0, 0, 0]
    var ballCollection: [SKShapeNode] = [];

    func initObjects(){
        // ボール
        for _ in 0..<10 {
            let radius: CGFloat = 20
            let ball = SKShapeNode(circleOfRadius:radius)
            ball.fillColor = UIColor(red: self.ballColor[0], green: self.ballColor[1], blue: self.ballColor[2], alpha: 1)
            // ランダムに配置
            let randIntX = radius + (CGFloat)(arc4random_uniform((UInt32)(self.frame.width-radius*2)))
            let randIntY = radius + (CGFloat)(arc4random_uniform((UInt32)(self.frame.height-radius*2)))
            ball.position = CGPoint(x:randIntX, y:randIntY)
            self.addChild(ball)
            // 重力
            ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            ball.physicsBody?.restitution = 1.0 // 反発係数
            ball.physicsBody?.linearDamping = 0.0 // 空気抵抗
            ball.physicsBody?.mass = 1.0 // 質量
            ball.physicsBody?.friction = 0.0 // 摩擦
            ball.physicsBody?.contactTestBitMask = 1
            self.ballCollection.append(ball)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nodeA = contact.bodyA.node {
            if let nodeB = contact.bodyB.node {
                if nodeA.name == "frame" || nodeB.name == "frame" {
                    // 壁との衝突
                    return
                }else {
                    // ボール同士の衝突
                    // パーティクル生成
                    let particle = SKEmitterNode(fileNamed: "ConflictParticle.sks")
                    self.addChild(particle!)

                    // ぶつかるたびにパーティクルが増えて処理が重くなるため
                    // パーティクルを表示してから1秒後に削除する
                    let removeAction = SKAction.removeFromParent()
                    let durationAction = SKAction.wait(forDuration: 1)
                    let sequenceAction = SKAction.sequence([durationAction, removeAction])
                    particle!.run(sequenceAction)
                
                    // ボールの位置にパーティクルを移動
                    particle!.position = CGPoint(x: nodeA.position.x, y: nodeA.position.y)
                    particle!.alpha = 1
                
                    let fadeAction = SKAction.fadeAlpha(by: 0, duration: 0.5)
                    particle!.run(fadeAction)
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        // 初期化処理
        self.initObjects()
        // 重力
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.physicsBody?.restitution = 1.0 // 反発係数
        self.physicsBody?.linearDamping = 0.0 // 空気抵抗
        self.physicsBody?.friction = 0.0 // 摩擦
        self.name = "frame"
        
        // CMMotionManagerを生成
        motionManager = CMMotionManager()
        // 加速度の値の取得間隔を設定する
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {(data, error) in
            print("x:\(data!.acceleration.x) y:\(data!.acceleration.y) z:\(data!.acceleration.z)")
            self.ballColor = [(CGFloat)(abs(data!.acceleration.x)), (CGFloat)(abs(data!.acceleration.y)), (CGFloat)(abs(data!.acceleration.z))]
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            _ = touch.location(in: self)
        }
    }
   
    override func update(_ currentTime: TimeInterval) {
        for ball in ballCollection {
            ball.fillColor = UIColor(red: self.ballColor[0], green: self.ballColor[1], blue: self.ballColor[2], alpha: 1)
        }
    }
}
