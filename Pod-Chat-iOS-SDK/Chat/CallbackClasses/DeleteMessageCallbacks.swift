//
//  DeleteMessageCallbacks.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 3/18/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftyBeaver
import FanapPodAsyncSDK


extension Chat {
    
    func responseOfDeleteMessage(withMessage message: ChatMessage) {
        /**
         *
         */
        log.verbose("Message of type 'DELETE_MESSAGE' recieved", context: "Chat")
        
        let returnData = CreateReturnData(hasError:         false,
                                          errorMessage:     "",
                                          errorCode:        0,
                                          result:           nil,
                                          resultAsArray:    nil,
                                          resultAsString:   message.content,
                                          contentCount:     message.contentCount,
                                          subjectId:        message.subjectId)
        
        if let content = message.content {
            let myMessage = Message(threadId:       message.subjectId,
                                    delivered:      nil,
                                    editable:       nil,
                                    edited:         nil,
                                    deletable:      nil,
                                    id:             Int(content) ?? 0,
                                    message:        nil,
                                    messageType:    nil,
                                    metaData:       nil,
                                    ownerId:        nil,
                                    previousId:     nil,
                                    seen:           nil,
                                    time:           nil,
                                    uniqueId:       nil,
                                    conversation:   nil,
                                    forwardInfo:    nil,
                                    participant:    nil,
                                    replyInfo:      nil)
            
            delegate?.messageEvents(type: MessageEventTypes.MESSAGE_DELETE, result: myMessage)
        }
        
        if enableCache {
            Chat.cacheDB.deleteMessage(inThread: message.subjectId!, allMessages: false, withMessageIds: [Int(message.content ?? "") ?? 0])
        }
        
        if Chat.map[message.uniqueId] != nil {    
            let callback: CallbackProtocol = Chat.map[message.uniqueId]!
            callback.onResultCallback(uID:      message.uniqueId,
                                      response: returnData,
                                      success:  { (successJSON) in
                self.deleteMessageCallbackToUser?(successJSON)
            }) { _ in }
            Chat.map.removeValue(forKey: message.uniqueId)
        }
    }
    
    
    public class DeleteMessageCallbacks: CallbackProtocol {
        var sendParams: SendChatMessageVO
        init(parameters: SendChatMessageVO) {
            self.sendParams = parameters
        }
        func onResultCallback(uID:      String,
                              response: CreateReturnData,
                              success:  @escaping callbackTypeAlias,
                              failure:  @escaping callbackTypeAlias) {
            log.verbose("DeleteMessageCallbacks", context: "Chat")
            
            if let content = response.resultAsString {
                
                let deletedMessageModel = DeleteMessageModel(deletedMessageId:  Int(content) ?? 0,
                                                             hasError:          response.hasError,
                                                             errorMessage:      response.errorMessage,
                                                             errorCode:         response.errorCode)
                
                success(deletedMessageModel)
            }
        }
        
    }
    
}
