//
//  ChatProtocols.swift
//  Chat
//
//  Created by Mahyar Zhiani on 7/23/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON


public typealias callbackTypeAlias = (Any) -> ()
public typealias callbackTypeAliasString = (String) -> ()
public typealias callbackTypeAliasFloat = (Float) -> ()

protocol CallbackProtocol: class {
    func onResultCallback(uID:      String,
                          response: CreateReturnData,
                          success:  @escaping callbackTypeAlias,
                          failure:  @escaping callbackTypeAlias)
}

protocol CallbackProtocolWith3Calls: class {
    func onSent(uID: String,    response: CreateReturnData, success: @escaping callbackTypeAlias)
    func onDeliver(uID: String, response: CreateReturnData, success: @escaping callbackTypeAlias)
    func onSeen(uID: String,    response: CreateReturnData, success: @escaping callbackTypeAlias)
}






public protocol ChatDelegates: class {
    
    func chatConnect()
    func chatDisconnect()
    func chatReconnect()
    func chatReady(withUserInfo: User)
    func chatState(state: Int)
    
    func chatError(errorCode: Int, errorMessage: String, errorResult: Any?)
    
    func botEvents(model: BotEventModel)
    func contactEvents(model: ContactEventModel)
    func fileUploadEvents(model: FileUploadEventModel)
    func messageEvents(model: MessageEventModel)
    func systemEvents(model: SystemEventModel)
    func threadEvents(model: ThreadEventModel)
    
}





