import Foundation
import SpriteKit

public class Dump: ObjectView{
    
    
    var spriteNode : SKSpriteNode?
    
    public init(){
        
        super.init(spriteImage: "dump")
        
    }
    
    public override func draw() -> SKSpriteNode {
        
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }
        
        return spriteNode!
        
    }
    
    public override func copy() -> Dump{
        
        return Dump()
        
    }
    
    
}
