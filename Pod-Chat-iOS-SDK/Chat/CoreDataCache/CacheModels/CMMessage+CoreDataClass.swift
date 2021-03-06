//
//  CMMessage+CoreDataClass.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 11/1/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//
//

import Foundation
import CoreData


public class CMMessage: NSManagedObject {
    
    public func convertCMMessageToMessageObject() -> Message {
        
        var deletable:      Bool?
        var delivered:      Bool?
        var editable:       Bool?
        var edited:         Bool?
        var id:             Int?
        var mentioned:      Bool?
        var ownerId:        Int?
        var pinned:         Bool?
        var previousId:     Int?
        var seen:           Bool?
        var threadId:       Int?
        var time:           UInt?
//        var timeNano:       UInt?
        
        func createVariables() {
            if let delivered2 = self.delivered as? Bool {
                delivered = delivered2
            }
            if let editable2 = self.editable as? Bool {
                editable = editable2
            }
            if let edited2 = self.edited as? Bool {
                edited = edited2
            }
            if let id2 = self.id as? Int {
                id = id2
            }
            if let mentioned2 = self.mentioned as? Bool {
                mentioned = mentioned2
            }
            if let ownerId2 = self.ownerId as? Int {
                ownerId = ownerId2
            }
            if let pinned2 = self.pinned as? Bool {
                pinned = pinned2
            }
            if let previousId2 = self.previousId as? Int {
                previousId = previousId2
            }
            if let seen2 = self.seen as? Bool {
                seen = seen2
            }
            if let threadId2 = self.threadId as? Int {
                threadId = threadId2
            }
            if let time2 = self.time as? UInt {
                time = time2
//                time = UInt(time2 / 100)
//                timeNano = (UInt(time2) - (time! * 100)) * (1000000)
            }
            if let deletable2 = self.deletable as? Bool {
                deletable = deletable2
            }
        }
        
        func createMessageModel() -> Message {
            let messageModel = Message(threadId:        threadId,
                                       deletable:       deletable,
                                       delivered:       delivered,
                                       editable:        editable,
                                       edited:          edited,
                                       id:              id,
                                       mentioned:       mentioned,
                                       message:         self.message,
                                       messageType:     self.messageType,
                                       metadata:        self.metadata,
                                       ownerId:         ownerId,
                                       pinned:          pinned,
                                       previousId:      previousId,
                                       seen:            seen,
                                       systemMetadata:  self.systemMetadata,
                                       time:            time,
                                       timeNanos:       0,
                                       uniqueId:        self.uniqueId,
                                       conversation:    conversation?.convertCMConversationToConversationObject(),
                                       forwardInfo:     forwardInfo?.convertCMForwardInfoToForwardInfoObject(),
                                       participant:     participant?.convertCMParticipantToParticipantObject(),
                                       replyInfo:       replyInfo?.convertCMReplyInfoToReplyInfoObject())
            return messageModel
        }
        
        createVariables()
        let model = createMessageModel()
        
        return model
        
    }
    
}
