//
//  IAPModel.swift
//  AnnaDJ
//
//  Created by yihuang on 2023/3/22.
//

import Foundation

class SoundModel: JsonModel {
    required init(json: JBJson) {
        self.title = json["title"].stringValue
        self.id = json["id"].stringValue
    }
    var title: String = ""
    var id: String = ""
}

class IAPModel: JsonModel {
    
    
    var defaultType: [SoundModel] = []
    
    var canBuyType: [SoundModel] = []
    
    required init(json: JBJson) {
        
        self.defaultType = json["defaultType"].arrayValue.map({SoundModel(json: $0)})

        self.canBuyType = json["canBuyType"].arrayValue.map({SoundModel(json: $0)}).filter({$0.id != ""})
    }

}


//    {
//      "defaultType": [
//        {
//          "title": "woodFish",
//          "id": ""
//        },
//        {
//          "title": "drum",
//          "id": ""
//        },
//        {
//          "title": "ring",
//          "id": ""
//        },
//        {
//          "title": "inSin",
//          "id": ""
//        },
//        {
//          "title": "gong",
//          "id": ""
//        }
//      ],
//      "canBuyType": [
//        {
//          "title": "board",
//          "id": "com.zlongame.lzgwy.tw"
//        },
//        {
//          "title": "clock",
//          "id": ""
//        },
//        {
//          "title": "dotRing",
//          "id": ""
//        },
//        {
//          "title": "traingle",
//          "id": ""
//        },
//        {
//          "title": "how",
//          "id": ""
//        },
//        {
//          "title": "oh",
//          "id": ""
//        },
//        {
//          "title": "airhorn",
//          "id": ""
//        },
//        {
//          "title": "gminor",
//          "id": ""
//        },
//        {
//          "title": "revCR",
//          "id": ""
//        },
//        {
//          "title": "loops",
//          "id": ""
//        },
//        {
//          "title": "fillin",
//          "id": ""
//        },
//        {
//          "title": "tuneUp",
//          "id": ""
//        },
//        {
//          "title": "acid",
//          "id": ""
//        },
//        {
//          "title": "bass",
//          "id": ""
//        },
//        {
//          "title": "crash",
//          "id": ""
//        },
//        {
//          "title": "open",
//          "id": ""
//        },
//        {
//          "title": "rootBPM",
//          "id": ""
//        },
//        {
//          "title": "synths",
//          "id": ""
//        },
//        {
//          "title": "kicks",
//          "id": ""
//        },
//        {
//          "title": "snares",
//          "id": ""
//        }
//      ]
//    }

