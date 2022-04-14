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
    let easyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let hardLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let backToMainMenuLabel = SKLabelNode(fontNamed: "Verdana-Bold")
    let playerNameField = UITextField()
    let playerNameFieldSize = CGSize(width: 300, height: 50)
    let blueSpaceship = SKSpriteNode(imageNamed: "blueSpaceship")
    let greenSpaceship = SKSpriteNode(imageNamed: "greenSpaceship")
    let easy = 5.0
    let hard = 1.0
    
   private var settings = Settings(playerName: nil, spaceshipName: nil, timer: nil)
 
    override func didMove(to view: SKView) {
        
        settings = SettingsManager.shared.loadSettings()
        
        if let name = settings.playerName {
            playerNameField.text = name
        }
        
        if let ship = settings.spaceshipName {
            switch ship {
            case "blueSpaceship":
                let scaleUpBlueShip = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownBlueShip = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleShipBlueSequance = SKAction.sequence([scaleUpBlueShip, scaleDownBlueShip])
                blueSpaceship.run(scaleShipBlueSequance)
                let scaleDownGreenShipTo1 = SKAction.scale(to: 1, duration: 0.2)
                greenSpaceship.run(scaleDownGreenShipTo1)
            case "greenSpaceship":
                let scaleUpGreenShip = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownGreenShip = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleShipGreenSequance = SKAction.sequence([scaleUpGreenShip, scaleDownGreenShip])
                greenSpaceship.run(scaleShipGreenSequance)
                let scaleDownBlueShipTo1 = SKAction.scale(to: 1, duration: 0.2)
                blueSpaceship.run(scaleDownBlueShipTo1)
            default:
                break
            }
        }
        
        if let timer = settings.timer {
            switch timer {
            case easy:
                let scaleUpEasy = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownEasy = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleEasySequance = SKAction.sequence([scaleUpEasy, scaleDownEasy])
                easyLabel.run(scaleEasySequance)
                let scaleDownMediumTo1 = SKAction.scale(to: 1, duration: 0.2)
                hardLabel.run(scaleDownMediumTo1)
            case hard:
                let scaleUpMedium = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownMedium = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleMediumSequance = SKAction.sequence([scaleUpMedium, scaleDownMedium])
                hardLabel.run(scaleMediumSequance)
                let scaleDownEasyTo1 = SKAction.scale(to: 1, duration: 0.2)
                easyLabel.run(scaleDownEasyTo1)
            default:
                break
            }
        }
        
        backgroundSetUp()
        settingsLabelSetUp()
        playerNameFieldSetUp()
        bluspaceshipSetUp()
        greenspaceshipSetUp()
        easyLabelSetUp()
        hardLabelSetUp()
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
        settingsLabel.fontSize = 40
        settingsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        settingsLabel.zPosition = 1
        addChild(settingsLabel)
    }
    
    func playerNameFieldSetUp() {
        playerNameField.borderStyle = UITextField.BorderStyle.roundedRect
        playerNameField.textColor = SKColor.black
        playerNameField.font = UIFont(name: "Verdana-Bold", size: 25)
        playerNameField.placeholder = "Enter your name"
        playerNameField.clearButtonMode = .unlessEditing
        playerNameField.frame = CGRect(x: self.frame.width * 0.15,
                                       y: self.frame.height * 0.25,
                                       width: playerNameFieldSize.width,
                                       height: playerNameFieldSize.height)
        self.view?.addSubview(playerNameField)
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
    
    func easyLabelSetUp() {
        easyLabel.text = "Easy"
        easyLabel.fontColor = SKColor.white
        easyLabel.fontSize = 25
        easyLabel.position = CGPoint(x: self.size.width * 0.3, y: self.frame.height * 0.35)
        easyLabel.zPosition = 1
        addChild(easyLabel)
    }
    
    func hardLabelSetUp() {
        hardLabel.text = "Hard"
        hardLabel.fontColor = SKColor.white
        hardLabel.fontSize = 25
        hardLabel.position = CGPoint(x: self.size.width * 0.7, y: self.frame.height * 0.35)
        hardLabel.zPosition = 1
        addChild(hardLabel)
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
                
                settings.playerName = playerNameField.text
                SettingsManager.shared.saveSettings(settings)
                
                self.playerNameField.removeFromSuperview()
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
            
            if easyLabel.contains(pointOfTouch) {
                let scaleUpEasy = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownEasy = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleEasySequance = SKAction.sequence([scaleUpEasy, scaleDownEasy])
                easyLabel.run(scaleEasySequance)
                let scaleDownMediumTo1 = SKAction.scale(to: 1, duration: 0.2)
                hardLabel.run(scaleDownMediumTo1)
                
                settings.timer = easy
                
            } else if hardLabel.contains(pointOfTouch) {
                let scaleUpMedium = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownMedium = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleMediumSequance = SKAction.sequence([scaleUpMedium, scaleDownMedium])
                hardLabel.run(scaleMediumSequance)
                let scaleDownEasyTo1 = SKAction.scale(to: 1, duration: 0.2)
                easyLabel.run(scaleDownEasyTo1)
                
                settings.timer = hard
            }
        }
    }
}




