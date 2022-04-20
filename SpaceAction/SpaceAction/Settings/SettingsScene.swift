//
//  SettingsScene.swift
//  SpaceAction
//
//  Created by A on 4/15/22.
//

import Foundation
import SpriteKit

class SettingsScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "starfield")
    let settingsLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let backToMainMenuLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let blueSpaceship = SKSpriteNode(imageNamed: "blueSpaceship")
    let greenSpaceship = SKSpriteNode(imageNamed: "greenSpaceship")
    
   private var settings = Settings(spaceshipName: nil, timer: nil)
 
    override func didMove(to view: SKView) {
        settings = SettingsManager.shared.loadSettings()
     
        if let ship = settings.spaceshipName {
            switch ship {
            case "blueSpaceship":
                let scaleUpBlueShip = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownBlueShip = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleShipBlueSequance = SKAction.sequence([scaleUpBlueShip, scaleDownBlueShip])
                blueSpaceship.run(scaleShipBlueSequance)
                let scaleDownGreenShipTo1 = SKAction.scale(to: 1, duration: 0.2)
                greenSpaceship.run(scaleDownGreenShipTo1)
            default:
                let scaleUpGreenShip = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownGreenShip = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleShipGreenSequance = SKAction.sequence([scaleUpGreenShip, scaleDownGreenShip])
                greenSpaceship.run(scaleShipGreenSequance)
                let scaleDownBlueShipTo1 = SKAction.scale(to: 1, duration: 0.2)
                blueSpaceship.run(scaleDownBlueShipTo1)
            }
        }
        
        backgroundSetUp()
        settingsLabelSetUp()
        bluspaceshipSetUp()
        greenspaceshipSetUp()
        backToMainMenuLabelSetUp()
    }
    func backgroundSetUp() {
        background.size = self.frame.size
        background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    func settingsLabelSetUp() {
        settingsLabel.text = "Settings"
        settingsLabel.fontColor = SKColor.white
        settingsLabel.fontSize = 30
        settingsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        settingsLabel.zPosition = 1
        addChild(settingsLabel)
    }
    func bluspaceshipSetUp() {
        blueSpaceship.position = CGPoint(x: self.size.width * 0.3, y: self.frame.height * 0.55)
        blueSpaceship.zPosition = 1
        blueSpaceship.size = CGSize(width: 100, height: 100)
        addChild(blueSpaceship)
    }
    func greenspaceshipSetUp() {
        greenSpaceship.position = CGPoint(x: self.size.width * 0.7, y: self.frame.height * 0.55)
        greenSpaceship.zPosition = 1
        greenSpaceship.size = CGSize(width: 100, height: 100)
        addChild(greenSpaceship)
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

            if backToMainMenuLabel.contains(pointOfTouch) {
                SettingsManager.shared.saveSettings(settings)
                
                let menuScene = MainMenuScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
            if blueSpaceship.contains(pointOfTouch) {
                let scaleUpBlueShip = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownBlueShip = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleShipBlueSequance = SKAction.sequence([scaleUpBlueShip, scaleDownBlueShip])
                blueSpaceship.run(scaleShipBlueSequance)
                let scaleDownGreenShipTo1 = SKAction.scale(to: 1, duration: 0.2)
                greenSpaceship.run(scaleDownGreenShipTo1)
                
                settings.spaceshipName = "blueSpaceship"

            } else if greenSpaceship.contains(pointOfTouch) {
                let scaleUpGreenShip = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownGreenShip = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleShipGreenSequance = SKAction.sequence([scaleUpGreenShip, scaleDownGreenShip])
                greenSpaceship.run(scaleShipGreenSequance)
                let scaleDownBlueShipTo1 = SKAction.scale(to: 1, duration: 0.2)
                blueSpaceship.run(scaleDownBlueShipTo1)
                
                settings.spaceshipName = "greenSpaceship"
            }
        }
    }
}




