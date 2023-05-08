//
//  DarknetTxtToJson.swift
//  DarknetToJson
//
//  Created by Mac8 on 08/05/2023.
//

import Foundation

struct DarknetTxtToJsonResponse: Codable {
    let imagefilename:String
    let annotation:Annotation
    
    struct Annotation: Codable {
        let coordinates:Coordinate
        let label:String
    }

    struct Coordinate: Codable {
        let y:Float
        let x:Float
        let height:Float
        let width:Float
    }
}

/*
 {
   "imagefilename": "breakfast_0.png",
   "annotation": [
     {
       "coordinates": {
         "y": 156.062,
         "x": 195.122,
         "height": 148.872,
         "width": 148.03
       },
       "label": "Waffle"
     }
   ]
 }
 */
