import Foundation
import SpriteKit

public class Tile: Drawable{

    
    let walkable: Bool
    let spriteImage: String
    private var spriteNode : SKSpriteNode?
    
    public init(spriteImage: String, walkable: Bool){
        
        self.spriteImage = spriteImage
        self.walkable = walkable
        
    }
    
    public func draw() -> SKSpriteNode {
        
        if(spriteNode == nil){
            
            spriteNode = SKSpriteNode(imageNamed: spriteImage)
            
        }

        return spriteNode!

    }
    
}
