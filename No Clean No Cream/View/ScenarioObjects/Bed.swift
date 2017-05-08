import Foundation
import SpriteKit

public class Bed: ScenarioObjectView {
    
    var isOrganized : Bool
    var spriteNode : SKSpriteNode?
    
    public init(isOrganized: Bool, place: SOPlace){
        
        self.isOrganized = isOrganized
        super.init(place: place)
        
    }
    
    public override func draw() -> SKSpriteNode {
        
        
        if(spriteNode == nil){
            if(isOrganized){
                switch place{
                    
                case .centerSprite:
                    spriteNode = SKSpriteNode(imageNamed: "bedCenterSprite")
                    
                case .upperLeft:
                    spriteNode = SKSpriteNode(imageNamed: "bedUpperLeft")
                    
                case .upperRight:
                    spriteNode = SKSpriteNode(imageNamed: "bedUpperRight")
                    
                case .downEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedDownEdge")
                    
                case .leftEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedLeftEdge")
                    
                case .lowerLeft:
                    spriteNode = SKSpriteNode(imageNamed: "bedLowerLeft")
                    
                case .lowerRight:
                    spriteNode = SKSpriteNode(imageNamed: "bedLowerRight")
                    
                case .rightEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedRightEdge")
                    
                case .upEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedUpEdge")
                    
                }
            }else{
                
                switch place{
                    
                case .centerSprite:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedCenterSprite")
                    
                case .upperLeft:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedUpperLeft")
                    
                case .upperRight:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedUpperRight")
                    
                case .downEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedDownEdge")
                    
                case .leftEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedLeftEdge")
                    
                case .lowerLeft:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedLowerLeft")
                    
                case .lowerRight:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedLowerRight")
                    
                case .rightEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedRightEdge")
                    
                case .upEdge:
                    spriteNode = SKSpriteNode(imageNamed: "bedDisorganizedUpEdge")
                    
                }
            }
        }
        
        if(spriteNode == nil){
            
            
            fatalError("Bed.draw(): spriteNode is nil")
            
        }
        
        return spriteNode!
        
    }
    
    public override func organizeIt() { 
        
        if(spriteNode == nil){
            
            fatalError("Bed.organizeIt(): spriteNode is nil")
            
        }
        
        organized = true
        
        switch place{
            
        case .centerSprite:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedCenterSprite")))
            
        case .upperLeft:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedUpperLeft")))
            
        case .upperRight:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedUpperRight")))
            
        case .downEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedDownEdge")))
            
        case .leftEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedLeftEdge")))
            
        case .lowerLeft:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedLowerLeft")))
            
        case .lowerRight:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedLowerRight")))
            
        case .rightEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedRightEdge")))
            
        case .upEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "bedUpEdge")))
            
        }
        
    }
    
    
}
