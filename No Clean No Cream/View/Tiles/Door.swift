import Foundation

public class Door: Tile{
    
    public init(place: SOPlace){
        
        if(place == SOPlace.lowerLeft){
            
            super.init(spriteImage: "doorLowerLeft", walkable: false)
            
        }else if (place == SOPlace.lowerRight){
            
            super.init(spriteImage: "doorLowerRight", walkable: false)
            
        }else if (place == SOPlace.leftEdge){
            
            super.init(spriteImage: "doorLeftEdge", walkable: false)
            
        }else if (place == SOPlace.rightEdge){
            
            super.init(spriteImage: "doorRightEdge", walkable: false)
            
        }else if (place == SOPlace.upperLeft){
            
            super.init(spriteImage: "doorUpperLeft", walkable: false)
            
        }else if (place == SOPlace.upperRight){
            
            super.init(spriteImage: "doorUpperRight", walkable: false)
            
        }else{
            
            print("[Error] Door.init: Couldn't find the spriteImage")
            super.init(spriteImage: "doorLeftEdge", walkable: false)
            
        }
        
    }
    
}
