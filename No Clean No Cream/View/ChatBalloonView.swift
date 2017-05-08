import Foundation
import SpriteKit

public class ChatBalloonView {
    
    private var character: CharacterView
    private var backgroundSprite: SKSpriteNode?
    private var labelText : SKLabelNode?
    private var iconImage : SKSpriteNode?
    private var seconds : Int?

    public init(characterView: CharacterView){
        
        self.character = characterView
        self.seconds = nil
        self.backgroundSprite = SKSpriteNode(imageNamed: "chatBalloon")
        backgroundSprite!.zPosition = 7
        
        self.backgroundSprite!.size = CGSize(width: 72, height: 72)
        self.backgroundSprite!.position.y = 72

        self.backgroundSprite!.alpha = 0.0
        
        self.labelText = nil
        self.iconImage = nil

        character.draw().addChild(backgroundSprite!)
        
    }
    
    public func draw(imageNamed: String) -> SKSpriteNode {
        
        if(iconImage != nil){
            
            iconImage!.removeFromParent()
            iconImage = nil
            
        }
        
        iconImage = SKSpriteNode(imageNamed: imageNamed)
        iconImage!.size = CGSize(width: 40, height: 40)
        iconImage!.position.y = 10
        backgroundSprite!.zPosition = 7
        iconImage!.zPosition = 8
        
        backgroundSprite!.addChild(iconImage!)
        
        backgroundSprite!.alpha = 1.0
        
        return backgroundSprite!
        
    }

}
