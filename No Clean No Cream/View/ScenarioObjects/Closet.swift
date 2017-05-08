import Foundation
import SpriteKit

public class Closet: ScenarioObjectView {
    
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
                    spriteNode = SKSpriteNode(imageNamed: "closetCenterSprite")
                    
                case .upperLeft:
                    spriteNode = SKSpriteNode(imageNamed: "closetUpperLeft")
                    
                case .upperRight:
                    spriteNode = SKSpriteNode(imageNamed: "closetUpperRight")
                    
                case .downEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetDownEdge")
                    
                case .leftEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetLeftEdge")
                    
                case .lowerLeft:
                    spriteNode = SKSpriteNode(imageNamed: "closetLowerLeft")
                    
                case .lowerRight:
                    spriteNode = SKSpriteNode(imageNamed: "closetLowerRight")
                    
                case .rightEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetRightEdge")
                    
                case .upEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetUpEdge")
                    
                }
            }else{
            
                switch place{
                    
                case .centerSprite:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedCenterSprite")
                    
                case .upperLeft:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedUpperLeft")
                    
                case .upperRight:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedUpperRight")
                    
                case .downEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedDownEdge")
                    
                case .leftEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedLeftEdge")
                    
                case .lowerLeft:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedLowerLeft")
                    
                case .lowerRight:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedLowerRight")
                    
                case .rightEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedRightEdge")
                    
                case .upEdge:
                    spriteNode = SKSpriteNode(imageNamed: "closetDisorganizedUpEdge")
                    
                }
            }
        }
    
        if(spriteNode == nil){
            
            
            fatalError("Closet.draw(): spriteNode is nil")
            
        }
        
        return spriteNode!
        
    }
    
    public override func organizeIt() {
        
        if(spriteNode == nil){
            
            fatalError("Closet.organizeIt(): spriteNode is nil")
            
        }
        
        organized = true
        
        switch place{
            
        case .centerSprite:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetCenterSprite")))
            
        case .upperLeft:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetUpperLeft")))
            
        case .upperRight:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetUpperRight")))
            
        case .downEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetDownEdge")))
            
        case .leftEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetLeftEdge")))
            
        case .lowerLeft:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetLowerLeft")))
            
        case .lowerRight:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetLowerRight")))
            
        case .rightEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetRightEdge")))
            
        case .upEdge:
            spriteNode!.run(SKAction.setTexture(SKTexture(imageNamed: "closetUpEdge")))
            
        }
        
        
    }
    
    
}
