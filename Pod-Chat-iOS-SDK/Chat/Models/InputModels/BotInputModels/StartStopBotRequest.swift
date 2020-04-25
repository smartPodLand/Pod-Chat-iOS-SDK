//
//  StartStopBotRequest.swift
//  FanapPodChatSDK
//
//  Created by MahyarZhiani on 2/5/1399 AP.
//  Copyright © 1399 Mahyar Zhiani. All rights reserved.
//

import SwiftyJSON

open class StartStopBotRequest {
    
    public let botName:     String
    public let threadId:    Int
    
    public let typeCode:    String?
    public let uniqueId:    String
    
    public init(botName:    String,
                threadId:   Int,
                typeCode:   String?,
                uniqueId:   String?) {
        
        self.botName    = botName
        self.threadId   = threadId
        
        self.typeCode   = typeCode
        self.uniqueId   = uniqueId ?? UUID().uuidString
    }
    
}