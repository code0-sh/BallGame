//
//  GameViewController.swift
//  BallGame
//
//  Created by omura.522 on 2015/07/24.
//  Copyright (c) 2015年 fssoftware. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // シーンの作成
        let scene = GameScene()
        
        // View ControllerのViewをSKView型として取り出す
        let view = self.view as! SKView
        
        // FPSの表示
        view.showsFPS = true
        
        // ノード数の表示
        view.showsNodeCount = true
        
        // シーンのサイズをビューに合わせる
        scene.size = view.frame.size

        // ビュー上にシーンを表示
        view.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
      if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
        return .AllButUpsideDown
      } else {
        return .All
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
