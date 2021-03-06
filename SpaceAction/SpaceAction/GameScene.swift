//
//  GameScene.swift
//  SpaceAction
//
//  Created by A on 4/13/22.
//

import SpriteKit
import GameKit
import CoreMotion

var score = Int()

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var stars: SKEmitterNode!
    var gameTimer: Timer!
    var enemies = ["alienspaceship", "alien80", "predator80", "ufo96"]
    let enemySize = CGSize(width: 70, height: 70)
    var player = SKSpriteNode()
    let playerSize = CGSize(width: 100, height: 100)
    let blueSpaceship = SKSpriteNode(imageNamed: "blueSpaceship")
    let greenSpaceship = SKSpriteNode(imageNamed: "greenSpaceship")
    let scoreLabel = SKLabelNode()
    var motionManager = CMMotionManager()
    var accelerationX: CGFloat  = 0.0
    
    enum gameState {
        case beforeTheGame
        case duringTheGame
        case afterTheGame
    }
    
    var currentGameState = gameState.duringTheGame
    
    struct PhysicsCategory {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1 //1
        static let Missile: UInt32 = 0b10 //2
        static let Enemy: UInt32 = 0b100 //4
//        static let NewLife: UInt32 = 0b101 //5
        static let NewFuel: UInt32 = 0b1000 //8
//        static let EdgeBody: UInt32 = 0b101 //6
        static let EdgeBody: UInt32 = 0b10000 //16
    }
    private var settings = Settings(spaceshipName: nil, timer: nil)
    
    override func didMove(to view: SKView) {
        settings = SettingsManager.shared.loadSettings()
        score = 0
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    
        sceneSetUp()
        playerSetUp()
        scoreLabelSetUp()
        gameTimerSetUp()
    }
    
    func gameTimerSetUp() {
        if let gTimer = settings.timer {
            gameTimer = Timer.scheduledTimer(timeInterval: gTimer, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        } else {
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }
    }
    
    func sceneSetUp() {
        scene?.size = UIScreen.main.bounds.size
        stars = SKEmitterNode(fileNamed: "Stars")
        stars.position = CGPoint (x: 0, y: 1000)
        stars.advanceSimulationTime(30)
        stars.zPosition = -1
        addChild(stars)
    }
    
    func playerSetUp() {
        if let playerSpaceship = settings.spaceshipName {
            player = SKSpriteNode(imageNamed: playerSpaceship)
        } else {
            player = SKSpriteNode(imageNamed: "greenSpaceship")
        }
        player.position.x = frame.midX
        player.position.y = frame.minY + player.size.height * 2
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player.physicsBody?.collisionBitMask = PhysicsCategory.None
        player.physicsBody?.collisionBitMask = PhysicsCategory.EdgeBody
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        player.size.width = playerSize.width
        player.size.height = playerSize.height
        addChild(player)
    }
    func scoreLabelSetUp() {
        scoreLabel.text = "Score: 0"
        scoreLabel.fontName = "Verdana-Bold"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: self.frame.minX + 20, y: self.frame.maxY - 70)
        scoreLabel.zPosition = 10
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.addChild(scoreLabel)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let pointOfTouch = touch.location(in: self)
        let previousPointOfTouch = touch.previousLocation(in: self)
        let offsetX = pointOfTouch.x - previousPointOfTouch.x

        if currentGameState == .duringTheGame {
            self.player.position.x += offsetX
        }
        if player.position.x > self.frame.maxX - player.size.width / 2 {
            player.position.x = self.frame.maxX - player.size.width / 2
        }
        if player.position.x < self.frame.minX + player.size.width / 2 {
            player.position.x = self.frame.minX + player.size.width / 2
        }
    }
    
    @objc func createEnemy() {
        enemies = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemies) as! [String]
        let enemy = SKSpriteNode(imageNamed: enemies[0])
        enemy.name = "Enemy"
        enemy.size.width = enemySize.width
        enemy.size.height = enemySize.height
        let lowestValueX = self.frame.minX + enemy.size.width
        let highestValueX = self.frame.maxX - enemy.size.width
        let randomEnemyPosition = GKRandomDistribution(lowestValue: Int(lowestValueX), highestValue: Int(highestValueX))
        let positionX = CGFloat(randomEnemyPosition.nextInt())
        enemy.position = CGPoint(x: positionX, y: self.size.height)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.None
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Missile
        self.addChild(enemy)
        
        let animationDuration: TimeInterval = 10.0
        var actionArray = [SKAction]()
        let positionXY = CGPoint(x: positionX, y: -self.size.height)
        
        actionArray.append(SKAction.move(to: positionXY, duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
       
        if currentGameState == .duringTheGame {
            enemy.run(SKAction.sequence(actionArray), withKey: "runCreateEnemy")
        }
    }
    
    func shootMissile() {
        let missile = SKSpriteNode(imageNamed: "missile")
        missile.name = "Missile"
        missile.position = player.position
        missile.zPosition = 0
        missile.physicsBody = SKPhysicsBody(rectangleOf: missile.size)
        missile.physicsBody?.affectedByGravity = false
        missile.physicsBody?.categoryBitMask = PhysicsCategory.Missile
        missile.physicsBody?.collisionBitMask = PhysicsCategory.None
        missile.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        missile.size.width = 50
        missile.size.height = 50
        self.addChild(missile)
        let shot = SKAction.moveTo(y: self.size.height + player.size.height, duration: 1)
        let deleteMissile = SKAction.removeFromParent()
        let shotSequance = SKAction.sequence([shot, deleteMissile])
        missile.run(shotSequance, withKey: "runShootMissile")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentGameState == .duringTheGame {
            shootMissile()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if body1.categoryBitMask == PhysicsCategory.Player && body2.categoryBitMask == PhysicsCategory.Enemy {
             if body1.node != nil {
                createExplosion(explosionPosition: body1.node!.position)
            }
            if body2.node != nil {
                createExplosion(explosionPosition: body2.node!.position)
            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            runGameOver()
        }
        if body1.categoryBitMask == PhysicsCategory.Missile && body2.categoryBitMask == PhysicsCategory.Enemy {
            if body2.node != nil {
                if body2.node!.position.y > self.size.height {
                    return
                } else {
                    increaseScore()
                    createExplosion(explosionPosition: body2.node!.position)
                }
            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
    }
    
    func createExplosion(explosionPosition: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "bigBang")
        explosion.position = explosionPosition
        explosion.zPosition = 3
        self.addChild(explosion)
        let scaleIn = SKAction.scale(to: 2.5, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let deleteExplosion = SKAction.removeFromParent()
        let explosionSequance = SKAction.sequence([scaleIn, fadeOut, deleteExplosion])
        explosion.run(explosionSequance)
    }
    
    func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func saveGameResults() {
        let date = Date()
        let formatter = DateFormatter()

        formatter.dateFormat = "dd.MM h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = .current
        let dateString = formatter.string(from: date)
        let newRecord = Record(score: score, date: dateString)
        RecordsManager.shared.saveRecords(newRecord)
        print("\(score) was saved to UD")
    }
    
    func runGameOver() {
        currentGameState = .afterTheGame
        self.enumerateChildNodes(withName: "Missile") {
            (missile, stop) in
             missile.removeAction(forKey: "runShootMissile")
        }
        self.enumerateChildNodes(withName: "Enemy") {
            (enemy, stop) in
            enemy.removeAction(forKey: "runCreateEnemy")
        }
        let changeGameSceneToGameOverSceneAction = SKAction.run(changeGameSceneToGameOverScene)
        let waitBeforeChangeScenes = SKAction.wait(forDuration: 1)
        let saveGameResultsAction = SKAction.run(saveGameResults)
        let changeGameSceneToGameOverSceneSequance = SKAction.sequence([saveGameResultsAction, waitBeforeChangeScenes, changeGameSceneToGameOverSceneAction])
        self.run(changeGameSceneToGameOverSceneSequance)
    }
    
    func changeGameSceneToGameOverScene() {
        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 1)
        self.view?.presentScene(gameOverScene, transition: sceneTransition)
    }
}
