//  Model.swift
//  Created by Behrooz Falsafi on 3/29/20.
//  Copyright © 2020 Behrooz Falsafi. All rights reserved.
//
import UIKit

//class Counry which is sub class of NSObject
class Country {

    let country:String!
    let slug:String!
    let nConf:String!
    //Create init function for one Country object. So when we create a country we can give it these string as well.
    init(country:String,slug:String,nConf:String) {
        self.country = country
        self.slug = slug
        self.nConf = nConf
    }
}
//note: we can also use struct instead of class but you can't use subclass in struct.

