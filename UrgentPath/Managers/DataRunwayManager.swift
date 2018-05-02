//
//  DataRunwayManager.swift
//  UrgentPath
//
//  Created by Jiashun Gou on 4/7/18.
//  Copyright © 2018 Jiashun Gou. All rights reserved.
//

import Foundation
import CoreLocation

class DataRunwayManager {
    static let shared = DataRunwayManager()//singleton
    
    private var data : [DataRunway]
    private var lastSortTime : Date
    
    private init() {
        data = [DataRunway]()
        lastSortTime = Date(timeIntervalSince1970: 0)
        readRunwayCSV()
    }
    
    private func readRunwayCSV() {
        let path = Bundle.main.path(forResource: "runways_with_mag_heading", ofType: "csv")
        if(path == nil){
            return
        }
        let url = URL(fileURLWithPath: path!)
        let content = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        
        let rows = content.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if(columns.count < 17){
                continue
            }
            let airportStr = columns[2].replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
            if(columns[8] != "" && columns[9] != "" && columns[10] != "" && columns[11] != "" && columns[13] != ""){
                let runwayNumStr = columns[8].replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
                let runway1 = DataRunway(runway_name: airportStr + runwayNumStr,
                                         runway_loc_x: Double(columns[9])!,
                                         runway_loc_y: Double(columns[10])!,
                                         runway_loc_z: Double(columns[11])!,
                                         runway_heading: Double(columns[13])!)
                data.append(runway1)
            }
            if(columns[15] != "" && columns[16] != "" && columns[17] != "" && columns[18] != "" && columns[20] != ""){
                let runwayNumStr = columns[15].replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
                let runway2 = DataRunway(runway_name: airportStr + runwayNumStr,
                                         runway_loc_x: Double(columns[16])!,
                                         runway_loc_y: Double(columns[17])!,
                                         runway_loc_z: Double(columns[18])!,
                                         runway_heading: Double(columns[20])!)
                data.append(runway2)
            }
        }
        print("Amount of runway read from csv file: " + String(data.count))
    }
    
    //sort runway from close to far by current location
    func sortRunway(loc_lat_1:Double, loc_lon_1:Double) {
        let elapsed = Date().timeIntervalSince(lastSortTime)
        if(elapsed < 120){ //update target airport every 120 seconds
            return
        }
        data = data.sorted(by: { getGeoDistance(loc_lat_1,
                                                loc_lon_1,
                                                $0.runway_loc_lat,
                                                $0.runway_loc_lon)
                                > getGeoDistance(loc_lat_1,
                                                 loc_lon_1,
                                                 $1.runway_loc_lat,
                                                 $1.runway_loc_lon) })
        lastSortTime = Date()
    }
    
    func getCloestRunway() -> DataRunway {
        return data[0]
    }
    
    //return distance between given 2 points in [meters]
    private func getGeoDistance(_ loc_lat_1:Double,
                                _ loc_lon_1:Double,
                                _ loc_lat_2:Double,
                                _ loc_lon_2:Double) -> Double {
        let loc1 = CLLocation(latitude: loc_lat_1, longitude: loc_lon_1)
        let loc2 = CLLocation(latitude: loc_lat_2, longitude: loc_lon_2)
        return loc1.distance(from: loc2)
    }
}
