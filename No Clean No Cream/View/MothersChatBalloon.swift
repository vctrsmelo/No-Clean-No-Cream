import Foundation
import SpriteKit

public class MothersChatBalloon{
    
    public var backgroundSprite: SKSpriteNode
    public var textLabel : SKLabelNode
    
    public init(){
        
        backgroundSprite = SKSpriteNode(imageNamed: "mothersChatBalloon")
        textLabel = SKLabelNode(text: "")
        textLabel.fontColor = SKColor.black
        backgroundSprite.anchorPoint = CGPoint(x: 0, y: 0)
        
        backgroundSprite.size = CGSize(width: 600, height: 40)
        backgroundSprite.position = CGPoint(x: 40, y: -30)
        
        backgroundSprite.alpha = 0.0
        
        backgroundSprite.addChild(textLabel)
        
    }
    
    public func draw() -> SKSpriteNode{
        
        return backgroundSprite
        
    }
    
    public func say(text: String){
        
        textLabel.text = text
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        adjustLabelFontSizeToFitRect(labelNode: textLabel, rect: CGRect(x: backgroundSprite.position.x, y: backgroundSprite.position.y, width: backgroundSprite.size.width, height: backgroundSprite.size.height))
        
        self.backgroundSprite.run(fadeIn)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+4) {

            self.backgroundSprite.run(fadeOut)

        }
        
    }
    
    func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min((rect.width - 40) / labelNode.frame.width, (rect.height) / labelNode.frame.height)
        
        // Change the fontSize.
        labelNode.fontSize *= scalingFactor
        var yMove: CGFloat = 0.0
        
        if(labelNode.fontSize >= 25){
            
            labelNode.fontSize = 25
            yMove = 15.0
            
        }else if(labelNode.fontSize < 25 && labelNode.fontSize >= 20){
         
            yMove = 20.0
           
        }else if(labelNode.fontSize < 18 && labelNode.fontSize >= 15){
            
            yMove = 22.0
           
        }else{
            
            yMove = 26.0
        
        }
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        let y = ((labelNode.frame.height) / 2.0)
        labelNode.position = CGPoint(x: (rect.width/2.0), y: y)

    }

    
}
