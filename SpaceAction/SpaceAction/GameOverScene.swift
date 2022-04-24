//
//  GameOverScene.swift
//  SpaceAction
//
//  Created by A on 4/14/22.
//

import Foundation
import SpriteKit


class GameOverScene: SKScene {
    
    var stars: SKEmitterNode!
    let restartButton = SKSpriteNode(imageNamed: "restartBtn")
    let gameOverLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let restartLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let recordsLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let backToMainMenuLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    var records: [Record] = []
    
    override func didMove(to view: SKView) {
        backgroundSetUp()
        gameOverLabelSetUp()
        recordsLabelSetUp()
        restartLabelSetUp()
        backToMainMenuLabelSetUp()
    }
    
    func backgroundSetUp() {
        let background = SKSpriteNode(imageNamed: "starfield")
        background.size = self.frame.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    
    func gameOverLabelSetUp() {
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
    }
    
    func recordsLabelSetUp() {
        recordsLabel.text = "Records"
        recordsLabel.fontColor = SKColor.white
        recordsLabel.fontSize = 30
        recordsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        recordsLabel.zPosition = 1
        addChild(recordsLabel)
    }
    
    func restartLabelSetUp() {
        restartLabel.text = "Restart"
        restartLabel.fontColor = SKColor.white
        restartLabel.fontSize = 30
        restartLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        restartLabel.zPosition = 1
        addChild(restartLabel)
    }
    
    func backToMainMenuLabelSetUp() {
        backToMainMenuLabel.text = "Back To Menu"
        backToMainMenuLabel.fontColor = SKColor.white
        backToMainMenuLabel.fontSize = 30
        backToMainMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMainMenuLabel.zPosition = 1
        addChild(backToMainMenuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            if restartLabel.contains(pointOfTouch) {
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(gameScene, transition: sceneTransition)
                
            }
            if recordsLabel.contains(pointOfTouch) {
                let recordsScene = RecordsScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(recordsScene, transition: sceneTransition)
            }
            if backToMainMenuLabel.contains(pointOfTouch) {
                let menuScene = MainMenuScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
        }
    }
}

