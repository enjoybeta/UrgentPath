//
//  DataRunway.swift
//  UrgentPath
//
//  Created by Jiashun Gou on 4/6/18.
//  Copyright © 2018 Jiashun Gou. All rights reserved.
//

import Foundation

struct DataRunway {
    var runway_name : String
    var runway_loc_lat : Double
    var runway_loc_lon : Double
    var runway_loc_z : Double
    var runway_heading : Double
    var runway_length : Int = 0
    var runway_width : Int = 0
    var runway_surface_quality : Double = 0.1
    
    init(runway_name: String,
         runway_loc_x : Double,
         runway_loc_y : Double,
         runway_loc_z : Double,
         runway_heading : Double,
         runway_length : Int,
         runway_width : Int,
         runway_surface_quality : Double = 0.1) {
        self.runway_name = runway_name
        self.runway_loc_lat = runway_loc_x
        self.runway_loc_lon = runway_loc_y
        self.runway_loc_z = runway_loc_z
        self.runway_heading = runway_heading
        self.runway_length = runway_length
        self.runway_width = runway_width
        self.runway_surface_quality = runway_surface_quality
    }
}
