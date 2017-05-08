import Foundation
import SpriteKit

public class TimerView{
    
    private var timeLeft : Int
    private var timerTextLabel : SKLabelNode
    private var timerLabel : SKLabelNode
    
    public init(){
        
        timeLeft = Config.TOTAL_TIME
        
        let minutes = floor(Double(timeLeft/60))
        let seconds = (timeLeft % 60)
        
        var secondsPrint : String = ""
        
        if(seconds < 10){
            
            secondsPrint = "0"+"\(seconds)"
            
        }else{
            
            secondsPrint = "\(seconds)"
            
        }


        timerLabel = SKLabelNode(text: "\(Int(minutes)):\(secondsPrint)")
        timerLabel.zPosition = 9
        timerLabel.position = CGPoint(x: (Config.MAP_WIDTH*Config.BLOCK_WIDTH)-Config.BLOCK_WIDTH*2,y: (Config.MAP_HEIGHT*Config.BLOCK_HEIGHT)+Config.BLOCK_HEIGHT)
        timerLabel.fontColor = SKColor.black
        timerLabel.fontSize = 24
        
        timerTextLabel = SKLabelNode(text: "Timer:")
        timerTextLabel.fontSize = 20
        timerTextLabel.zPosition = 9
        timerTextLabel.fontColor = SKColor.black
        let yTextLabel =  timerLabel.position.y+timerLabel.fontSize+2.0
        timerTextLabel.position = CGPoint(x: 0, y: timerLabel.fontSize+2)
        
        timerLabel.addChild(timerTextLabel)
        
    }
    
    public func nextTime(){
        
        timeLeft -= 1
        let minutes = floor(Double(timeLeft/60))
        let seconds = (timeLeft % 60)
        
        var secondsPrint : String = ""
        
        if(seconds < 10){
            
            secondsPrint = "0"+"\(seconds)"
            
        }else{
            
            secondsPrint = "\(seconds)"
            
        }
        
        timerLabel.text = "\(Int(minutes)):\(secondsPrint)"
        
    }
    
    public func draw() -> SKLabelNode {
        
        
        
        return timerLabel
        
    }
    
}
