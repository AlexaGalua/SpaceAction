//
//  MainMenuScene.swift
//  SpaceAction
//
//  Created by A on 4/13/22.
//

import Foundation
import SpriteKit



class MainMenuScene: SKScene {
    
    // MARK: - Variables
    var stars: SKEmitterNode!
    
    // MARK: - Constants
    let gameNameLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let startGameLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let recordsLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let settingsLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    
    // MARK: - Lifecycle Functions
    override func didMove(to view: SKView) {

//        scene?.size = UIScreen.main.bounds.size
//        stars = SKEmitterNode(fileNamed: "Stars")
////        stars.position = CGPoint (x: 0, y: 1000)
//        stars.position = CGPoint (x: 0, y: self.size.height)
//        //stars.position = CGPoint (x: self.size.width, y: self.size.height)
//        stars.advanceSimulationTime(30)
//        stars.zPosition = -1
//        addChild(stars)
        
        backgroundSetUp()
        gameNameLabelSetUp()
        startGameLabelSetUp()
        recordsLabelSetUp()
        settingsLabelSetUp()
    }


    
    // MARK: - Flow Functions
    func backgroundSetUp() {
        let background = SKSpriteNode(imageNamed: "starfield")
        background.size = self.frame.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    
    func gameNameLabelSetUp() {
        gameNameLabel.text = "Space Mission"
        gameNameLabel.fontColor = SKColor.white
        gameNameLabel.fontSize = 50
        gameNameLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameNameLabel.zPosition = 1
        addChild(gameNameLabel)
    }
    
    func startGameLabelSetUp() {
        startGameLabel.text = "Start"
        startGameLabel.fontColor = SKColor.white
        startGameLabel.fontSize = 30
        startGameLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        startGameLabel.zPosition = 1
        addChild(startGameLabel)
    }
    
    func recordsLabelSetUp() {
        recordsLabel.text = "Records"
        recordsLabel.fontColor = SKColor.white
        recordsLabel.fontSize = 30
        recordsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        recordsLabel.zPosition = 1
        addChild(recordsLabel)
    }
    
    func settingsLabelSetUp() {
        settingsLabel.text = "Settings"
        settingsLabel.fontColor = SKColor.white
        settingsLabel.fontSize = 30
        settingsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.3)
        settingsLabel.zPosition = 1
        addChild(settingsLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: UITouch in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if startGameLabel.contains(pointOfTouch) {
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(gameScene, transition: sceneTransition)
            }
            
            if recordsLabel.contains(pointOfTouch) {
                let recordsScene = RecordsScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(recordsScene, transition: sceneTransition)
            }
            
            if settingsLabel.contains(pointOfTouch) {
                let settingsScene = SettingsScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(settingsScene, transition: sceneTransition)
            }
        }
    }
}
