import Foundation
import SpriteKit

public class PointsView{
    
    private var points : Int
    private var pointsTextLabel : SKLabelNode
    private var pointsLabel : SKLabelNode
    
    public init(){

        points = 0
        
        pointsLabel = SKLabelNode(text: "0")
        pointsLabel.zPosition = 9
        pointsLabel.position = CGPoint(x: (Config.MAP_WIDTH*Config.BLOCK_WIDTH)-Config.BLOCK_WIDTH,y: (Config.MAP_HEIGHT*Config.BLOCK_HEIGHT)+Config.BLOCK_HEIGHT)
        pointsLabel.fontColor = SKColor.black
        pointsLabel.fontSize = 24
        
        pointsTextLabel = SKLabelNode(text: "Points:")
        pointsTextLabel.fontSize = 20
        pointsTextLabel.zPosition = 9
        pointsTextLabel.fontColor = SKColor.black
        let yTextLabel =  pointsLabel.position.y+pointsLabel.fontSize+2.0
        pointsTextLabel.position = CGPoint(x: 0, y: pointsLabel.fontSize+2)
        
        
        pointsLabel.addChild(pointsTextLabel)
        
    }
    
    public func sum(newPoints: Int){
        
        self.points += newPoints
        pointsLabel.text = "\(self.points)"
        
    }
    
    public func draw() -> SKLabelNode {

        return pointsLabel
        
    }

}
