import Foundation
import SpriteKit

public class ToyBox: ScenarioObjectView {
    
    var isOrganized : Bool
    var spriteNode : SKSpriteNode?
    
    public init(isOrganized: Bool, place: SOPlace){
        
        self.isOrganized = isOrganized
        super.init(place: place)
        
    }
    
    public override func draw() -> SKSpriteNode {
        
        
        switch place{
            
        case .centerSprite:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxCenterSprite")
            
        case .upperLeft:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxUpperLeft")
            
        case .upperRight:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxUpperRight")
            
        case .downEdge:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxDownEdge")
            
        case .leftEdge:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxLeftEdge")
            
        case .lowerLeft:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxLowerLeft")
            
        case .lowerRight:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxLowerRight")
            
        case .rightEdge:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxRightEdge")
            
        case .upEdge:
            spriteNode = SKSpriteNode(imageNamed: "toyBoxUpEdge")
            
        }
        
        if(spriteNode == nil){
            
            
            fatalError("ToyBox.draw(): spriteNode is nil")
            
        }
        
        return spriteNode!
        
    }
    
    public override func organizeIt() {
        
    }
    
    
}
