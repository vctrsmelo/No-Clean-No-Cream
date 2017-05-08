import Foundation
import SpriteKit

public class Desk: ScenarioObjectView {
    
    var isOrganized : Bool
    var spriteNode : SKSpriteNode?
    
    public init(isOrganized: Bool, place: SOPlace){
        
        self.isOrganized = isOrganized
        super.init(place: place)
        
    }
    
    public override func draw() -> SKSpriteNode {
        
        
        if (spriteNode == nil){
            if(isOrganized){
                switch place{
                    
                case .centerSprite:
                    spriteNode = SKSpriteNode(imageNamed: "deskCenterSprite")
                    
                case .upperLeft:
                    spriteNode = SKSpriteNode(imageNamed: "deskUpperLeft")
                    
                case .upperRight:
                    spriteNode = SKSpriteNode(imageNamed: "deskUpperRight")
                    
                case .downEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskDownEdge")
                    
                case .leftEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskLeftEdge")
                    
                case .lowerLeft:
                    spriteNode = SKSpriteNode(imageNamed: "deskLowerLeft")
                    
                case .lowerRight:
                    spriteNode = SKSpriteNode(imageNamed: "deskLowerRight")
                    
                case .rightEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskRightEdge")
                    
                case .upEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskUpEdge")
                    
                }
            }else{
                
                switch place{
                    
                case .centerSprite:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedCenterSprite")
                    
                case .upperLeft:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedUpperLeft")
                    
                case .upperRight:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedUpperRight")
                    
                case .downEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedDownEdge")
                    
                case .leftEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedLeftEdge")
                    
                case .lowerLeft:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedLowerLeft")
                    
                case .lowerRight:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedLowerRight")
                    
                case .rightEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedRightEdge")
                    
                case .upEdge:
                    spriteNode = SKSpriteNode(imageNamed: "deskDisorganizedUpEdge")
                    
                }
            }
        }
        
        if(spriteNode == nil){
            
            
            fatalError("Desk.draw(): spriteNode is nil")
            
        }
        
        return spriteNode!
        
    }
    
    public override func organizeIt() {
        
        if(spriteNode == nil){
            
            fatalError("Desk.organizeIt(): spriteNode is nil")
            
        }
        
        organized = true
        
        switch place{
            
        case .centerSprite:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskCenterSprite")))
            
        case .upperLeft:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskUpperLeft")))
            
        case .upperRight:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskUpperRight")))
            
        case .downEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskDownEdge")))
            
        case .leftEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskLeftEdge")))
            
        case .lowerLeft:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskLowerLeft")))
            
        case .lowerRight:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskLowerRight")))
            
        case .rightEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskRightEdge")))
            
        case .upEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "deskUpEdge")))
            
        }
        
        
    }
    
    
}
