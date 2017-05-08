import Foundation
import SpriteKit

public class Toy: ObjectView{
    
    
    var spriteNode : SKSpriteNode?
    
    public init(){

        super.init(spriteImage: "toy1")
        
    }
    
    public override func draw() -> SKSpriteNode {
        
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }
        
        return spriteNode!
        
    }
    
    public override func copy() -> Toy{
        
        return Toy()
        
    }
    
}
