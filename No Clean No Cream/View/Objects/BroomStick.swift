import Foundation
import SpriteKit

public class BroomStick: ObjectView{
    
    
    var spriteNode : SKSpriteNode?
    
    public init(){
    
        super.init(spriteImage: "broomStick")

    }
    
    public override func draw() -> SKSpriteNode {
        
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }
        
        return spriteNode!
        
    }
    
    public override func copy() -> BroomStick{
        
        return BroomStick()
        
    }
    
    
}
