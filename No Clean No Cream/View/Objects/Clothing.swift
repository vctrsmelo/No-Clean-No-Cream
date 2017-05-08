import Foundation
import SpriteKit

public class Clothing: ObjectView{
    
    
    var spriteNode : SKSpriteNode?
    
    public init(){
    
        super.init(spriteImage: "clothing1")

    }
    
    public override func draw() -> SKSpriteNode {
        
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }
        
        return spriteNode!
        
    }
    
    public override func copy() -> Clothing{
        
        return Clothing()
        
    }
    
    
}
