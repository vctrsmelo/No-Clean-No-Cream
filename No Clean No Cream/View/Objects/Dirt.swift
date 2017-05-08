import Foundation
import SpriteKit

public class Dirt: ObjectView{
    
    
    var spriteNode : SKSpriteNode?
    
    public init(){
        
        super.init(spriteImage: "dirt")
        
    }
    
    public override func draw() -> SKSpriteNode {
        
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }
        
        return spriteNode!
        
    }
    
    public override func copy() -> Dirt{
        
        return Dirt()
        
    }
    
    
}
