public class Wall: Tile{
    
    public init(place: SOPlace){
        
        if(place == SOPlace.downEdge){
        
            super.init(spriteImage: "wallDownEdge", walkable: false)
        
        }else if (place == SOPlace.centerSprite){
            
            super.init(spriteImage: "wallCenterSprite", walkable: false)
        
        }else if (place == SOPlace.upEdge){
            
            super.init(spriteImage: "wallUpEdge", walkable: false)
            
        }else{
            
            super.init(spriteImage: "wallCenterSprite", walkable: false)
            
        }
        
    }
    
}
