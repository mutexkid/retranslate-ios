//
//  Translation.swift
//  retranslate
//
//  Created by josh skeen on 1/20/15.
//  Copyright (c) 2015 josh skeen. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Translation : Printable {
    
    let imgUrl:String
    let startingPhrase:String
    let endingPhrase:String
    let id:Int
    let translationSteps:[TranslationStep]
    
    init(response:JSON){
        imgUrl = response["image"].stringValue
        let node = response["translation"]
        startingPhrase = node["starting_phrase"].stringValue
        endingPhrase = node["ending_phrase"].stringValue
        id = node["id"].intValue
        translationSteps = TranslationStep.parseTranslationSteps(response)
    }
    
    var description: String {
        return "(imgUrl: \(imgUrl), id: \(id), \n starting: \(startingPhrase), \n ending: \(endingPhrase), steps: [\(translationSteps)])"
    }
    
}