//
//  GetContactsModel.swift
//  Chat
//
//  Created by Mahyar Zhiani on 7/23/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON


open class GetContactsModel {
    /*
     ---------------------------------------
     * responseAsJSON:
     *  - hasError      Bool
     *  - errorMessage  String
     *  - errorCode     Int
     *  + result            [JSON]:
     *      - contentCount      Int
     *      - hasNext           Bool
     *      - nextOffset        Int
     *      + contacts          ContactsAsJSON
     *          - id                Int
     *          - userId            Int
     *          - firstName         String
     *          - lastName          String
     *          - image             String
     *          - email             String
     *          - cellphoneNumber   String
     *          - uniqueId          String
     *          - notSeenDuration   Int
     *          - hasUser           Bool
     *          - linkedUser        LinkedUser
     ---------------------------------------
     * responseAsModel:
     *  - hasError      Bool
     *  - errorMessage  String
     *  - errorCode     Int
     *  + contact       [Contact]
     ---------------------------------------
     */
    
    // GetContact model properties
    let hasError:           Bool
    let errorMessage:       String
    let errorCode:          Int
    
    // result model
    var contentCount:       Int = 0
    var hasNext:            Bool = false
    var nextOffset:         Int = 0
    var contacts:           [Contact] = []
    
    var contacrsJSON:       [JSON] = []
    
    init(messageContent: [JSON], contentCount: Int, count: Int, offset: Int, hasError: Bool, errorMessage: String, errorCode: Int) {
        
        self.hasError           = hasError
        self.errorMessage       = errorMessage
        self.errorCode          = errorCode
        
        let messageLength = messageContent.count
        self.contentCount = contentCount
        self.hasNext = false
        let x: Int = count + offset
        if (x < contentCount) && (messageLength > 0) {
            self.hasNext = true
        }
        self.nextOffset = offset + messageLength
        
        for item in messageContent {
            let cont = Contact(messageContent: item)
            let contJSON = cont.formatToJSON()
            
            contacts.append(cont)
            contacrsJSON.append(contJSON)
        }
        
    }
    
    public func returnDataAsJSON() -> JSON {
        let result: JSON = ["contentCount": contentCount,
                            "hasNext":      hasNext,
                            "nextOffset":   nextOffset,
                            "contacts":     contacrsJSON]
        
        let finalResult: JSON = ["result": result,
                                 "hasError": hasError,
                                 "errorMessage": errorMessage,
                                 "errorCode": errorCode]
        
        return finalResult
    }
    
}


