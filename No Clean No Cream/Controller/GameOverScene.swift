import Foundation
import SpriteKit

public class GameOverScene : SKScene{
    
    private var mainTextLabel: SKLabelNode
    private var textDescriptionLabel: SKLabelNode
    
    public init(size: CGSize,textMain: String, textDescription: String){
        
        self.mainTextLabel = SKLabelNode(text: textMain)
        self.textDescriptionLabel = SKLabelNode(text: textDescription)
        
        
        super.init(size: size)
        
        self.mainTextLabel.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        self.mainTextLabel.fontColor = SKColor.black
        self.backgroundColor = SKColor.white
        self.mainTextLabel.position.y += 15
        
        self.textDescriptionLabel.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        self.textDescriptionLabel.fontColor = SKColor.black
        self.backgroundColor = SKColor.white
        self.textDescriptionLabel.fontSize = 18.0
        self.textDescriptionLabel.position.y -= 15
        
        self.addChild(mainTextLabel)
        self.addChild(textDescriptionLabel)
    
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
