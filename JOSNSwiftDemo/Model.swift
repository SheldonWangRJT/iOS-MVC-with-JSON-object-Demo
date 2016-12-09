//
//  Model.swift
//  JOSNSwiftDemo
//
//  Created by Shinkangsan on 12/8/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit

class Actor {

    let name:String!
    let dob:String!
    let imageStr:String!
    
    init(name:String,dob:String,img:String) {
        self.name = name
        self.dob = dob
        self.imageStr = img
    }
    
    
}

struct Actor2 {
    
    let name:String!
    let dob:String!
    let imageStr:String!
    
    init(name:String,dob:String,img:String) {
        self.name = name
        self.dob = dob
        self.imageStr = img
    }
}
