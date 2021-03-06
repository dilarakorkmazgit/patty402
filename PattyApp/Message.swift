//
//  Message.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 3.01.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {

    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    func chatPartnerId() -> String? {
        
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
        
        
    }
}
