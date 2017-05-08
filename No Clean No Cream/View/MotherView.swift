import Foundation
import SpriteKit

public class MotherView{
    
    private var spriteNode : SKSpriteNode
    private var mothersChatBalloon : MothersChatBalloon
    
    public init(){
        
        spriteNode = SKSpriteNode(imageNamed: "mother")
        
        spriteNode.position = CGPoint(x: 40, y: Config.MAP_HEIGHT*Config.BLOCK_HEIGHT+Config.BLOCK_HEIGHT/2)
        spriteNode.size = CGSize(width: Config.BLOCK_WIDTH, height: Config.BLOCK_HEIGHT)
        
        mothersChatBalloon = MothersChatBalloon()
        
        spriteNode.addChild(mothersChatBalloon.draw())
        
    }
    
    public func draw() -> SKSpriteNode {
        
        return spriteNode
        
    }
    
    public func say(text: String){
     
        mothersChatBalloon.say(text: text)
        
    }
    
}
