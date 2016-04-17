import UIKit
import MapKit


class Hackathon: NSObject {
    
    
    
    var teamSize: Int!
    
    var location: CLLocationCoordinate2D!
    
    var name: String
    
    var date: String
    
    var blurb: String!
    
    var address: String
    
    var members: [Member]!
    
    var image: UIImage
    
    var bgimage: UIImage
    
    var prizes: [Prize]!
    
    
    
    init(name: String, image: UIImage, date: String, blurb: String, location: CLLocationCoordinate2D, teamSize: Int, prizes: [Prize], members: [Member], address: String, bgimg: UIImage) {
        
        self.teamSize = teamSize ?? 4
        
        self.name = name
        
        self.location = location
        
        self.date = date
        
        self.blurb = blurb ?? ""
        
        self.image = image
        
        self.prizes = prizes ?? []
        
        self.address = address
        
        self.members = members ?? []
        
        self.bgimage = bgimg
        
        
        
        super.init()
        
    }
    
    
    
}



class Connection: NSObject {
    
    
    
    var fromTeam: Team
    
    var toHack: Hackathon
    
    
    
    init(fromTeam: Team, toHack: Hackathon)
        
    {
        
        self.fromTeam = fromTeam
        
        self.toHack = toHack
        
        super.init()
        
    }
    
}



class Prize: NSObject {
    
    var amount: Int
    
    var sponsor: String
    
    var blurb: String
    
    
    
    init(amount: Int, sponsor: String, blurb: String) {
        
        self.amount = amount
        
        self.blurb = blurb
        
        self.sponsor = sponsor
        
        super.init()
        
    }
    
    
    
}



class Member: NSObject {
    
    
    
}



class Team: NSObject {
    
    var members: [Member]
    
    var forHack: Hackathon
    
    
    
    init(members: [Member], forHack: Hackathon){
        
        self.members = members
        
        self.forHack = forHack
        
        super.init()
        
    }
    
}




