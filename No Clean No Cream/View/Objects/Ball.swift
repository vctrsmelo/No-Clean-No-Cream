import Foundation
import SpriteKit

public class Ball: ObjectView{
    
    
    var spriteNode : SKSpriteNode?
    
    public init(){
        
        super.init(spriteImage: "ball1")
    
    }
    
    public override func draw() -> SKSpriteNode {
    
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }
        
        return spriteNode!
        
    }
    
    public override func copy() -> Ball{
        
        return Ball()
        
    }
    
    
}
