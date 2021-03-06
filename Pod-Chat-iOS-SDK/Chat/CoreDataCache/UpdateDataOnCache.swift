//
//  UpdateDataOnCache.swift
//  FanapPodChatSDK
//
//  Created by Mahyar Zhiani on 3/18/1398 AP.
//  Copyright © 1398 Mahyar Zhiani. All rights reserved.
//

import Foundation
import CoreData


extension Cache {
    
    // MARK: - update Contact:
    /*
     * Update CMContact Entity:
     *
     * -> fetch CMContact and see if we already had this contact on the Cache or not
     * -> if we found one, we will update it's properties
     * -> if not, we will create an CMContact object and save it in the Cache
     *
     *  + Access:   Private
     *  + Inputs:
     *      - withContactObject:    Contact
     *  + Outputs:
     *      - CMContact?
     *
     */
    func updateCMContactEntity(withContactObject myContact: Contact) -> CMContact? {
        var contactToReturn: CMContact?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMContact")
        if let contactId = myContact.id {
            fetchRequest.predicate = NSPredicate(format: "id == %i", contactId)
            do {
                if let result = try context.fetch(fetchRequest) as? [CMContact] {
                    if (result.count > 0) {
                        if let blocked = myContact.blocked as NSNumber? {
                            result.first!.blocked = blocked
                        }
                        if let cellphoneNumber = myContact.cellphoneNumber {
                            result.first!.cellphoneNumber = cellphoneNumber
                        }
                        if let email = myContact.email {
                            result.first!.email = email
                        }
                        if let firstName = myContact.firstName {
                            result.first!.firstName = firstName
                        }
                        if let hasUser = myContact.hasUser as NSNumber? {
                            result.first!.hasUser = hasUser
                        }
                        if let id = myContact.id as NSNumber? {
                            result.first!.id = id
                        }
                        if let image = myContact.image {
                            result.first!.image = image
                        }
                        if let lastName = myContact.lastName {
                            result.first!.lastName = lastName
                        }
                        if let notSeenDuration = myContact.notSeenDuration as NSNumber? {
                            result.first!.notSeenDuration = notSeenDuration
                        }
                        if let userId = myContact.userId as NSNumber? {
                            result.first!.userId = userId
                        }
                        if let timeStamp = myContact.timeStamp as NSNumber? {
                            result.first!.time = timeStamp
                        }
//                        result.first!.blocked           = myContact.blocked as NSNumber?
//                        result.first!.cellphoneNumber   = myContact.cellphoneNumber
//                        result.first!.email             = myContact.email
//                        result.first!.firstName         = myContact.firstName
//                        result.first!.hasUser           = myContact.hasUser as NSNumber?
//                        result.first!.id                = myContact.id as NSNumber?
//                        result.first!.image             = myContact.image
//                        result.first!.lastName          = myContact.lastName
//                        result.first!.notSeenDuration   = myContact.notSeenDuration as NSNumber?
////                        result.first!.uniqueId          = myContact.uniqueId
//                        result.first!.userId            = myContact.userId as NSNumber?
//                        result.first!.time              = myContact.timeStamp as NSNumber? // Int(Date().timeIntervalSince1970) as NSNumber?
                        if let contactLinkeUser = myContact.linkedUser {
                            let linkedUserObject = updateCMLinkedUserEntity(withLinkedUser: contactLinkeUser)
                            result.first!.linkedUser = linkedUserObject
                        }
                        contactToReturn = result.first!
                        saveContext(subject: "Update CMContact -update existing object-")
                        
                    } else {
                        let theContactEntity = NSEntityDescription.entity(forEntityName: "CMContact", in: context)
                        let theContact = CMContact(entity: theContactEntity!, insertInto: context)
                        theContact.blocked          = myContact.blocked as NSNumber?
                        theContact.cellphoneNumber  = myContact.cellphoneNumber
                        theContact.email            = myContact.email
                        theContact.firstName        = myContact.firstName
                        theContact.hasUser          = myContact.hasUser as NSNumber?
                        theContact.id               = myContact.id as NSNumber?
                        theContact.image            = myContact.image
                        theContact.lastName         = myContact.lastName
                        theContact.notSeenDuration  = myContact.notSeenDuration as NSNumber?
//                        theContact.uniqueId         = myContact.uniqueId
                        theContact.userId           = myContact.userId as NSNumber?
                        theContact.time             = myContact.timeStamp as NSNumber? // Int(Date().timeIntervalSince1970) as NSNumber?
                        if let contactLinkeUser = myContact.linkedUser {
                            let linkedUserObject = updateCMLinkedUserEntity(withLinkedUser: contactLinkeUser)
                            theContact.linkedUser = linkedUserObject
                        }
                        contactToReturn = theContact
                        saveContext(subject: "Update CMContact -create new object-")
                    }
                }
            } catch {
                fatalError("Error on trying to find the contact from CMContact entity")
            }
        }
        return contactToReturn
    }
    
    
    
    // MARK: - update LinkedUser:
    /*
     * Update CMLinkedUser Entity:
     *
     * -> fetch CMLinkedUser and see if we already had this linkedUser on the Cache or not
     * -> if we found one, we will update it's properties
     * -> if not, we will create an CMLinkedUser object and save it in the Cache
     *
     *  + Access:   Private
     *  + Inputs:
     *      - withLinkedUser:   LinkedUser
     *  + Outputs:
     *      - CMLinkedUser?
     *
     */
    func updateCMLinkedUserEntity(withLinkedUser myLinkedUser: LinkedUser) -> CMLinkedUser? {
        var linkedUserToReturn: CMLinkedUser?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMLinkedUser")
        if let linkedUserId = myLinkedUser.coreUserId {
            fetchRequest.predicate = NSPredicate(format: "coreUserId == %i", linkedUserId)
            do {
                if let result = try context.fetch(fetchRequest) as? [CMLinkedUser] {
                    if (result.count > 0) {
                        if let coreUserId = myLinkedUser.coreUserId as NSNumber? {
                            result.first!.coreUserId = coreUserId
                        }
                        if let image = myLinkedUser.image {
                            result.first!.image = image
                        }
                        if let name = myLinkedUser.name {
                            result.first!.name = name
                        }
                        if let nickname = myLinkedUser.nickname {
                            result.first!.nickname = nickname
                        }
                        if let username = myLinkedUser.username {
                            result.first!.username = username
                        }
//                        result.first!.coreUserId    = myLinkedUser.coreUserId as NSNumber?
//                        result.first!.image         = myLinkedUser.image
//                        result.first!.name          = myLinkedUser.name
//                        result.first!.nickname      = myLinkedUser.nickname
//                        result.first!.username      = myLinkedUser.username
                        linkedUserToReturn = result.first!
                        saveContext(subject: "Update CMLinkedUser -update existing object-")
                    } else {
                        let theLinkedUserEntity = NSEntityDescription.entity(forEntityName: "CMLinkedUser", in: context)
                        let theLinkedUser = CMLinkedUser(entity: theLinkedUserEntity!, insertInto: context)
                        
                        theLinkedUser.coreUserId    = myLinkedUser.coreUserId as NSNumber?
                        theLinkedUser.image         = myLinkedUser.image
                        theLinkedUser.name          = myLinkedUser.name
                        theLinkedUser.nickname      = myLinkedUser.nickname
                        theLinkedUser.username      = myLinkedUser.username
                        linkedUserToReturn = theLinkedUser
                        saveContext(subject: "Update CMLinkedUser -create new object-")
                    }
                }
            } catch {
                fatalError("Error on trying to find the linkedUser from CMLinkedUser entity")
            }
        }
        return linkedUserToReturn
    }
    
    
    
    // MARK: - update Conversation:
    /*
     * Update CMConversation Entity:
     *
     * -> fetch CMConversation objcets from the CMConversation Entity,
     *    and see if we already had this Conversation on the cache or not
     * -> if we found the object on the Entity, we will update the property values of it,
     * -> if not, we will create CMConversation object and save it on the Cache
     *
     *  + Access:   Private
     *  + Inputs:
     *      - withConversationObject:   Conversation
     *  + Outputs:
     *      - CMConversation?
     *
     */
    func updateCMConversationEntity(withConversationObject myThread: Conversation) -> CMConversation? {
        var conversationToReturn: CMConversation?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMConversation")
        if let threadId = myThread.id {
            fetchRequest.predicate = NSPredicate(format: "id == %i", threadId)
            do {
                if let result = try context.fetch(fetchRequest) as? [CMConversation] {
                    if (result.count > 0) {
                        if let admin = myThread.admin as NSNumber? {
                            result.first!.admin = admin
                        }
                        if let canEditInfo = myThread.canEditInfo as NSNumber? {
                            result.first!.canEditInfo = canEditInfo
                        }
                        if let canSpam = myThread.canSpam as NSNumber? {
                            result.first!.canSpam = canSpam
                        }
                        if let descriptions = myThread.description {
                            result.first!.descriptions = descriptions
                        }
                        if let group = myThread.group as NSNumber? {
                            result.first!.group = group
                        }
                        if let id = myThread.id as NSNumber? {
                            result.first!.id = id
                        }
                        if let image = myThread.image {
                            result.first!.image = image
                        }
                        if let joinDate = myThread.joinDate as NSNumber? {
                            result.first!.joinDate = joinDate
                        }
                        if let lastMessage = myThread.lastMessage {
                            result.first!.lastMessage = lastMessage
                        }
                        if let lastParticipantImage = myThread.lastParticipantImage {
                            result.first!.lastParticipantImage = lastParticipantImage
                        }
                        if let lastParticipantName = myThread.lastParticipantName {
                            result.first!.lastParticipantName = lastParticipantName
                        }
                        if let lastSeenMessageId = myThread.lastSeenMessageId as NSNumber? {
                            result.first!.lastSeenMessageId = lastSeenMessageId
                        }
                        if let mentioned = myThread.mentioned as NSNumber? {
                            result.first!.mentioned = mentioned
                        }
                        if let metadata = myThread.metadata {
                            result.first!.metadata = metadata
                        }
                        if let mute = myThread.mute as NSNumber? {
                            result.first!.mute = mute
                        }
                        if let participantCount = myThread.participantCount as NSNumber? {
                            result.first!.participantCount = participantCount
                        }
                        if let partner = myThread.partner as NSNumber? {
                            result.first!.partner = partner
                        }
                        if let partnerLastDeliveredMessageId = myThread.partnerLastDeliveredMessageId as NSNumber? {
                            result.first!.partnerLastDeliveredMessageId = partnerLastDeliveredMessageId
                        }
                        if let partnerLastSeenMessageId = myThread.partnerLastSeenMessageId as NSNumber? {
                            result.first!.partnerLastSeenMessageId = partnerLastSeenMessageId
                        }
                        if let pin = myThread.pin as NSNumber? {
                            result.first!.pin = pin
                        }
                        if let title = myThread.title {
                            result.first!.title = title
                        }
                        if let time = myThread.time as NSNumber? {
                            result.first!.time = time
                        }
                        if let type = myThread.type as NSNumber? {
                            result.first!.type = type
                        }
                        if let unreadCount = myThread.unreadCount as NSNumber? {
                            result.first!.unreadCount = unreadCount
                        }
                        
//                        result.first!.admin                 = (myThread.admin as NSNumber?) ?? (result.first!.admin)
//                        result.first!.canEditInfo           = (myThread.canEditInfo as NSNumber?) ?? (result.first!.canEditInfo)
//                        result.first!.canSpam               = (myThread.canSpam as NSNumber?) ?? (result.first!.canSpam)
//                        result.first!.descriptions          = (myThread.description) ?? (result.first!.descriptions)
//                        result.first!.group                 = (myThread.group as NSNumber?) ?? (result.first!.group)
//                        result.first!.id                    = (myThread.id as NSNumber?) ?? (result.first!.id)
//                        result.first!.image                 = (myThread.image) ?? (result.first!.image)
//                        result.first!.joinDate              = (myThread.joinDate as NSNumber?) ?? (result.first!.joinDate)
//                        result.first!.lastMessage           = myThread.lastMessage
//                        result.first!.lastParticipantImage  = myThread.lastParticipantImage
//                        result.first!.lastParticipantName   = myThread.lastParticipantName
//                        result.first!.lastSeenMessageId     = myThread.lastSeenMessageId as NSNumber?
//                        result.first!.mentioned             = myThread.mentioned as NSNumber?
//                        result.first!.metadata              = myThread.metadata
//                        result.first!.mute                  = myThread.mute as NSNumber?
//                        result.first!.participantCount      = myThread.participantCount as NSNumber?
//                        result.first!.partner               = myThread.partner as NSNumber?
//                        result.first!.partnerLastDeliveredMessageId = myThread.partnerLastDeliveredMessageId as NSNumber?
//                        result.first!.partnerLastSeenMessageId      = myThread.partnerLastSeenMessageId as NSNumber?
//                        result.first!.pin                   = myThread.pin as NSNumber?
//                        result.first!.title                 = myThread.title
//                        result.first!.time                  = myThread.time as NSNumber?
//                        result.first!.type                  = myThread.time as NSNumber?
//                        result.first!.unreadCount           = myThread.unreadCount as NSNumber?
                        if let threadInviter = myThread.inviter {
                            let inviterObject = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: threadInviter, isAdminRequest: false)
                            result.first!.inviter = inviterObject
                        }
                        if let threadLastMessageVO = myThread.lastMessageVO {
                            let messageObject = updateCMMessageEntity(withMessageObject: threadLastMessageVO)
                            result.first!.lastMessageVO = messageObject
                        }
                        if let pinMessage = myThread.pinMessage {
                            deleteAllPinMessageFromCMMessageEntity(onThreadId: threadId)
                            if let pin = updateCMPinMessageEntity(withObject: pinMessage) {
                                result.first!.pinMessage = pin
                            }
                        }
                        
                        // this part is deprecated because the server is no longer sends Participants on the Conversation model
//                        if let threadParticipants = myThread.participants, (threadParticipants.count > 0) {
//                            var threadParticipantsArr = [CMParticipant]()
//                            for item in threadParticipants {
//                                if let threadparticipant = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: item, isAdminRequest: false) {
//                                    threadParticipantsArr.append(threadparticipant)
////                                    updateThreadParticipantEntity(inThreadId: Int(exactly: result.first!.id!)!, withParticipantId: Int(exactly: threadparticipant.id!)!)
////                                    result.first!.participants?.append(threadparticipant)
//                                }
//                            }
//                            result.first!.addToParticipants(threadParticipantsArr)
//                        }
                        
                        conversationToReturn = result.first!
                        
                        saveContext(subject: "Update CMConversation -update existing object-")
                    } else {
                        let conversationEntity = NSEntityDescription.entity(forEntityName: "CMConversation", in: context)
                        let conversation = CMConversation(entity: conversationEntity!, insertInto: context)
                        conversation.admin                  = myThread.admin as NSNumber?
                        conversation.canEditInfo            = myThread.canEditInfo as NSNumber?
                        conversation.canSpam                = myThread.canSpam as NSNumber?
                        conversation.descriptions           = myThread.description
                        conversation.group                  = myThread.group as NSNumber?
                        conversation.id                     = myThread.id as NSNumber?
                        conversation.image                  = myThread.image
                        conversation.joinDate               = myThread.joinDate as NSNumber?
                        conversation.lastMessage            = myThread.lastMessage
                        conversation.lastParticipantImage   = myThread.lastParticipantImage
                        conversation.lastParticipantName    = myThread.lastParticipantName
                        conversation.lastSeenMessageId      = myThread.lastSeenMessageId as NSNumber?
                        conversation.mentioned              = myThread.mentioned as NSNumber?
                        conversation.metadata               = myThread.metadata
                        conversation.mute                   = myThread.mute as NSNumber?
                        conversation.participantCount       = myThread.participantCount as NSNumber?
                        conversation.partner                = myThread.partner as NSNumber?
                        conversation.partnerLastDeliveredMessageId  = myThread.partnerLastDeliveredMessageId as NSNumber?
                        conversation.partnerLastSeenMessageId       = myThread.partnerLastSeenMessageId as NSNumber?
                        conversation.pin                    = myThread.pin as NSNumber?
                        conversation.title                  = myThread.title
                        conversation.time                   = myThread.time as NSNumber?
                        conversation.type                   = myThread.time as NSNumber?
                        conversation.unreadCount            = myThread.unreadCount as NSNumber?
                        if let threadInviter = myThread.inviter {
                            let inviterObject = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: threadInviter, isAdminRequest: false)
                            conversation.inviter = inviterObject
                        }
                        if let threadLastMessageVO = myThread.lastMessageVO {
                            let messageObject = updateCMMessageEntity(withMessageObject: threadLastMessageVO)
                            conversation.lastMessageVO = messageObject
                        }
                        if let pinMessage = myThread.pinMessage {
                            deleteAllPinMessageFromCMMessageEntity(onThreadId: threadId)
                            if let pin = updateCMPinMessageEntity(withObject: pinMessage) {
                                conversation.pinMessage = pin
                            }
                        }
                        
                        // this part is deprecated because the server is no longer sends Participants on the Conversation model
//                        if let threadParticipants = myThread.participants, (threadParticipants.count > 0) {
//                            var threadParticipantsArr = [CMParticipant]()
//                            for item in threadParticipants {
//                                if let threadparticipant = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: item, isAdminRequest: false) {
//                                    threadParticipantsArr.append(threadparticipant)
////                                    updateThreadParticipantEntity(inThreadId: Int(exactly: conversation.id!)!, withParticipantId: Int(exactly: threadparticipant.id!)!)
////                                    conversation.participants?.append(threadparticipant) // this line causes crash!!
//                                }
//                            }
//                            conversation.addToParticipants(threadParticipantsArr)
//                        }
                        
                        conversationToReturn = conversation
                        
                        saveContext(subject: "Update CMConversation -create new object-")
                    }
                }
            } catch {
                fatalError("Error on trying to find the thread from CMConversation entity")
            }
        }
        return conversationToReturn
    }
    
    
    
    func updateUnreadCountOnCMConversation(withThreadId threadId: Int, unreadCount: Int?, addCount: Int?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMConversation")
        fetchRequest.predicate = NSPredicate(format: "id == %i", threadId)
        do {
            if let result = try context.fetch(fetchRequest) as? [CMConversation] {
                if result.count > 0 {
                    if let count = unreadCount {
                        result.first!.unreadCount = count as NSNumber
                    } else if let add = addCount {
                        let count = Int(truncating: result.first!.unreadCount ?? 0)
                        result.first!.unreadCount = (count + add) as NSNumber
                    }
                }
            }
        } catch {
            fatalError("Error on trying to find the thread from CMConversation entity to update unreadCount")
        }
    }
    
    
    
    // MARK: - update Participant:
    /*
     * Update Participant Entity:
     *
     * -> fetch the CMParticipant objcet from the CMParticipant Entity,
     *    and see if we already had this Participant object on the cache or not
     * -> if we found the object on the Entity, we will update the property values of it
     * -> if not, we will create CMParticipant object and save it on the Cache
     *
     *  + Access:   Private
     *  + Inputs:
     *      - withConversationObject:   Conversation
     *  + Outputs:
     *      - CMConversation?
     *
     */
    func updateCMParticipantEntity(inThreadId threadId: Int, withParticipantsObject myParticipant: Participant, isAdminRequest: Bool) -> CMParticipant? {
        var participantObjectToReturn: CMParticipant?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMParticipant")
        // if i found the CMParticipant onject, update its values
        if let participantId = myParticipant.id {
            fetchRequest.predicate = NSPredicate(format: "id == %i AND threadId == %i", participantId, threadId)
            do {
                if let result = try context.fetch(fetchRequest) as? [CMParticipant] {
                    if (result.count > 0) {
                        if let admin = myParticipant.admin as NSNumber? {
                            result.first!.admin = admin
                        }
                        if let auditor = myParticipant.auditor as NSNumber? {
                            result.first!.auditor = auditor
                        }
                        if let blocked = myParticipant.blocked as NSNumber? {
                            result.first!.blocked = blocked
                        }
                        if let cellphoneNumber = myParticipant.cellphoneNumber {
                            result.first!.cellphoneNumber = cellphoneNumber
                        }
                        if let contactFirstName = myParticipant.contactFirstName {
                            result.first!.contactFirstName = contactFirstName
                        }
                        if let contactId = myParticipant.contactId as NSNumber? {
                            result.first!.contactId = contactId
                        }
                        if let contactName = myParticipant.contactName {
                            result.first!.contactName = contactName
                        }
                        if let contactLastName = myParticipant.contactLastName {
                            result.first!.contactLastName = contactLastName
                        }
                        if let email = myParticipant.email {
                            result.first!.email = email
                        }
                        if let firstName = myParticipant.firstName {
                            result.first!.firstName = firstName
                        }
                        if let id = myParticipant.id as NSNumber? {
                            result.first!.id = id
                        }
                        if let image = myParticipant.image {
                            result.first!.image = image
                        }
                        if let keyId = myParticipant.keyId {
                            result.first!.keyId = keyId
                        }
                        if let lastName = myParticipant.lastName {
                            result.first!.lastName = lastName
                        }
                        if let myFriend = myParticipant.myFriend as NSNumber? {
                            result.first!.myFriend = myFriend
                        }
                        if let name = myParticipant.name {
                            result.first!.name = name
                        }
                        if let notSeenDuration = myParticipant.notSeenDuration as NSNumber? {
                            result.first!.notSeenDuration = notSeenDuration
                        }
                        if let online = myParticipant.online as NSNumber? {
                            result.first!.online = online
                        }
                        if let receiveEnable = myParticipant.receiveEnable as NSNumber? {
                            result.first!.receiveEnable = receiveEnable
                        }
                        if isAdminRequest {
                            result.first!.roles = (myParticipant.roles != []) ? myParticipant.roles : nil
                        } else {
                            result.first!.roles = ((myParticipant.roles?.count ?? 0) > 0) ? myParticipant.roles : result.first!.roles
                        }
                        if let sendEnable = myParticipant.sendEnable as NSNumber? {
                            result.first!.sendEnable = sendEnable
                        }
                        if let theThreadId = threadId as NSNumber? {
                            result.first!.threadId = theThreadId
                        }
                        if let username = myParticipant.username {
                            result.first!.username = username
                        }
                        result.first!.time = Int(Date().timeIntervalSince1970) as NSNumber?
                        result.first!.admin = ((result.first!.roles?.count ?? 0) > 0) ? true : false
//                        result.first!.admin             = myParticipant.admin as NSNumber?
//                        result.first!.auditor           = myParticipant.auditor as NSNumber?
//                        result.first!.blocked           = myParticipant.blocked as NSNumber?
//                        result.first!.cellphoneNumber   = myParticipant.cellphoneNumber
//                        result.first!.contactFirstName  = myParticipant.contactFirstName
//                        result.first!.contactId         = myParticipant.contactId as NSNumber?
//                        result.first!.contactName       = myParticipant.contactName
//                        result.first!.contactLastName   = myParticipant.contactLastName
//                        result.first!.email             = myParticipant.email
//                        result.first!.firstName         = myParticipant.firstName
//                        result.first!.id                = myParticipant.id as NSNumber?
//                        result.first!.image             = myParticipant.image
//                        result.first!.keyId             = myParticipant.keyId
//                        result.first!.lastName          = myParticipant.lastName
//                        result.first!.myFriend          = myParticipant.myFriend as NSNumber?
//                        result.first!.name              = myParticipant.name
//                        result.first!.notSeenDuration   = myParticipant.notSeenDuration as NSNumber?
//                        result.first!.online            = myParticipant.online as NSNumber?
//                        result.first!.receiveEnable     = myParticipant.receiveEnable as NSNumber?
//                        if isAdminRequest {
//                            result.first!.roles         = (myParticipant.roles != []) ? myParticipant.roles : nil
//                        } else {
//                            result.first!.roles         = ((myParticipant.roles?.count ?? 0) > 0) ? myParticipant.roles : result.first!.roles
//                        }
//                        result.first!.sendEnable        = myParticipant.sendEnable as NSNumber?
//                        result.first!.threadId          = threadId as NSNumber?
//                        result.first!.time              = Int(Date().timeIntervalSince1970) as NSNumber?
//                        result.first!.username          = myParticipant.username
//
//                        result.first!.admin             = ((result.first!.roles?.count ?? 0) > 0) ? true : false
                        participantObjectToReturn = result.first!
                        
                        saveContext(subject: "Update CMParticipant -update existing object-")
                    } else {    // it means that we couldn't find the CMParticipant object on the cache, so we will create one
                        let theParticipantEntity = NSEntityDescription.entity(forEntityName: "CMParticipant", in: context)
                        let theParticipant = CMParticipant(entity: theParticipantEntity!, insertInto: context)
                        theParticipant.admin            = myParticipant.admin as NSNumber?
                        theParticipant.auditor          = myParticipant.auditor as NSNumber?
                        theParticipant.blocked          = myParticipant.blocked as NSNumber?
                        theParticipant.cellphoneNumber  = myParticipant.cellphoneNumber
                        theParticipant.contactFirstName = myParticipant.contactFirstName
                        theParticipant.contactId        = myParticipant.contactId as NSNumber?
                        theParticipant.contactName      = myParticipant.contactName
                        theParticipant.contactLastName  = myParticipant.contactLastName
                        theParticipant.email            = myParticipant.email
                        theParticipant.firstName        = myParticipant.firstName
                        theParticipant.id               = myParticipant.id as NSNumber?
                        theParticipant.image            = myParticipant.image
                        theParticipant.keyId            = myParticipant.keyId
                        theParticipant.lastName         = myParticipant.lastName
                        theParticipant.myFriend         = myParticipant.myFriend as NSNumber?
                        theParticipant.name             = myParticipant.name
                        theParticipant.notSeenDuration  = myParticipant.notSeenDuration as NSNumber?
                        theParticipant.online           = myParticipant.online as NSNumber?
                        theParticipant.receiveEnable    = myParticipant.receiveEnable as NSNumber?
                        theParticipant.roles            = (myParticipant.roles != []) ? myParticipant.roles : nil
                        theParticipant.sendEnable       = myParticipant.sendEnable as NSNumber?
                        theParticipant.threadId         = threadId as NSNumber?
                        theParticipant.time             = Int(Date().timeIntervalSince1970) as NSNumber?
                        theParticipant.username         = myParticipant.username
                        participantObjectToReturn = theParticipant
                        
                        saveContext(subject: "Update CMParticipant -create a new object-")
                    }
                }
            } catch {
                fatalError("Error on trying to find the participant from CMParticipant entity")
            }
        }
        return participantObjectToReturn
    }
    
    
    
    /*
    
    func updateThreadAdminEntity(inThreadId threadId: Int, roles: UserRole) -> ThreadAdmins? {
        /*
         *  -> fetch ThreadAdmins with threadId and userId
         *  -> if 'roles' Input, has some roles, then we will update or create threadAdmin
         *  -> otherwise we will delete that object from cache if that was exist
         *
         */
        var threadAdminObjectToReturn: ThreadAdmins?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ThreadAdmins")
        // if i found the ThreadAdmins onject, update its values
        fetchRequest.predicate = NSPredicate(format: "threadId == %i && userId == %i", threadId, roles.userId)
        do {
            if let result = try context.fetch(fetchRequest) as? [ThreadAdmins] {
                if (roles.roles?.count ?? 0 > 0) {
                    if (result.count > 0) {
                        result.first!.threadId  = threadId as NSNumber?
                        result.first?.name      = roles.name
                        result.first?.userId    = roles.userId as NSNumber?
                        var userRoles = [String]()
                        for role in roles.roles ?? [] {
                            userRoles.append(role)
                        }
                        result.first?.roles     = userRoles
                        threadAdminObjectToReturn = result.first
                        saveContext(subject: "Update ThreadAdmins -update existing object-")
                        
                    } else {    // it means that we couldn't find the ThreadAdmins object on the cache, so we will create one
                        let theThreadAdminEntity = NSEntityDescription.entity(forEntityName: "ThreadAdmins", in: context)
                        let threadAdmin = ThreadAdmins(entity: theThreadAdminEntity!, insertInto: context)
                        threadAdmin.threadId    = threadId as NSNumber?
                        threadAdmin.name        = roles.name
                        threadAdmin.userId      = roles.userId as NSNumber?
                        var userRoles = [String]()
                        for role in roles.roles ?? [] {
                            userRoles.append(role)
                        }
                        threadAdmin.roles       = userRoles
                        threadAdminObjectToReturn = threadAdmin
                        saveContext(subject: "Update ThreadAdmins -create a new object-")
                    }
                    
                } else {
                    if (result.count > 0) {
                        deleteAndSave(object: result.first!, withMessage: "Delete Admin from ThreadAdmin entity")
                        saveContext(subject: "Update ThreadAdmins -update existing object-")
                    }
                }
                
            }
        } catch {
            fatalError("Error on trying to find the object from ThreadAdmins entity")
        }
        return threadAdminObjectToReturn
    }
    
    */
    
    
    
    // MARK: - update Message:
    /*
     * Update Message Entity:
     *
     * -> fetch the CMMessage objcet from the CMMessage Entity,
     *    and see if we already had this Participant object on the cache or not
     * -> if we found the object on the Entity, we will update the property values of it
     * -> if not, we will create CMMessage object and save it on the Cache
     *
     *  + Access:   Private
     *  + Inputs:
     *      - withMessageObject:    Message
     *  + Outputs:
     *      - CMMessage?
     *
     */
    func updateCMMessageEntity(withMessageObject myMessage: Message) -> CMMessage? {
        var messageObjectToReturn: CMMessage?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMMessage")
        if let messageId = myMessage.id {
            fetchRequest.predicate = NSPredicate(format: "id == %i", messageId)
            do {
                if let result = try context.fetch(fetchRequest) as? [CMMessage] {
                    if (result.count > 0) {
                        if let delivered = myMessage.delivered as NSNumber? {
                            result.first!.delivered = delivered
                        }
                        if let editable = myMessage.editable as NSNumber? {
                            result.first!.editable = editable
                        }
                        if let edited = myMessage.edited as NSNumber? {
                            result.first!.edited = edited
                        }
                        if let id = myMessage.id as NSNumber? {
                            result.first!.id = id
                        }
                        if let mentioned = myMessage.mentioned as NSNumber? {
                            result.first!.mentioned = mentioned
                        }
                        if let message = myMessage.message {
                            result.first!.message = message
                        }
                        if let messageType = myMessage.messageType {
                            result.first!.messageType = messageType
                        }
                        if let metadata = myMessage.metadata {
                            result.first!.metadata = metadata
                        }
                        if let ownerId = myMessage.ownerId as NSNumber? {
                            result.first!.ownerId = ownerId
                        }
                        if let previousId = myMessage.previousId as NSNumber? {
                            result.first!.previousId = previousId
                        }
                        if let seen = myMessage.seen as NSNumber? {
                            result.first!.seen = seen
                        }
                        if let systemMetadata = myMessage.systemMetadata {
                            result.first!.systemMetadata = systemMetadata
                        }
                        if let threadId = myMessage.threadId as NSNumber? {
                            result.first!.threadId = threadId
                        }
                        if let time = myMessage.time as NSNumber? /*, let timeNano = myMessage.timeNanos*/ {
//                            let theTime = ((UInt(time / 1000)) * 1000000000 ) + timeNano
//                            result.first!.time = theTime as NSNumber
                            result.first!.time = time
                        }
                        if let uniqueId = myMessage.uniqueId {
                            result.first!.uniqueId = uniqueId
                        }
                        
//                        result.first!.delivered         = myMessage.delivered as NSNumber?
//                        result.first!.editable          = myMessage.editable as NSNumber?
//                        result.first!.edited            = myMessage.edited as NSNumber?
//                        result.first!.id                = myMessage.id as NSNumber?
//                        result.first!.mentioned         = myMessage.mentioned as NSNumber?
//                        result.first!.message           = myMessage.message
//                        result.first!.messageType       = myMessage.messageType
//                        result.first!.metadata          = myMessage.metadata
//                        result.first!.ownerId           = myMessage.ownerId as NSNumber?
//                        result.first!.previousId        = myMessage.previousId as NSNumber?
//                        result.first!.seen              = myMessage.seen as NSNumber?
//                        result.first!.systemMetadata    = myMessage.systemMetadata
//                        result.first!.threadId          = myMessage.threadId as NSNumber?
//                        result.first!.time              = myMessage.time as NSNumber?
//                        result.first!.uniqueId          = myMessage.uniqueId
                        if let messageConversation = myMessage.conversation {
                            if let conversationObject = updateCMConversationEntity(withConversationObject: messageConversation) {
                                result.first!.conversation = conversationObject
                            }
                        }
                        if let messageParticipant = myMessage.participant {
                            if let participantObject = updateCMParticipantEntity(inThreadId: myMessage.threadId!, withParticipantsObject: messageParticipant, isAdminRequest: false) {
                                result.first!.participant = participantObject
                            }
                        }
                        
                        if let messageForwardInfo = myMessage.forwardInfo {
                            if let conversation = messageForwardInfo.conversation {
                                if let thId = conversation.id {
                                    result.first!.forwardInfo = createCMForwardInfo(fromObject: messageForwardInfo, onThreadId: thId)
//                                    let forward = updateCMForwardInfoEntity(inThreadId: thId, withObject: messageForwardInfo)
//                                    result.first!.forwardInfo = forward
                                }
                            }
                        }
                        if let messageReplyInfo = myMessage.replyInfo {
                            result.first!.replyInfo = createCMReplyInfo(fromObject: messageReplyInfo, onThreadId: myMessage.threadId!)
//                            if let reply = updateCMReplyInfoEntity(inThreadId: myMessage.threadId!, withObject: messageReplyInfo) {
//                                result.first!.replyInfo = reply
//                            }
                        }
                        
                        messageObjectToReturn = result.first!
                        saveContext(subject: "Update CMMessage -update existing object-")
                        
                    } else {
                        let theMessageEntity = NSEntityDescription.entity(forEntityName: "CMMessage", in: context)
                        let theMessage = CMMessage(entity: theMessageEntity!, insertInto: context)
                        theMessage.delivered        = myMessage.delivered as NSNumber?
                        theMessage.editable         = myMessage.editable as NSNumber?
                        theMessage.edited           = myMessage.edited as NSNumber?
                        theMessage.id               = myMessage.id as NSNumber?
                        theMessage.mentioned        = myMessage.mentioned as NSNumber?
                        theMessage.message          = myMessage.message
                        theMessage.messageType      = myMessage.messageType
                        theMessage.metadata         = myMessage.metadata
                        theMessage.ownerId          = myMessage.ownerId as NSNumber?
                        theMessage.previousId       = myMessage.previousId as NSNumber?
                        theMessage.seen             = myMessage.seen as NSNumber?
                        theMessage.systemMetadata   = myMessage.systemMetadata
                        theMessage.threadId         = myMessage.threadId as NSNumber?
                        theMessage.time             = myMessage.time as NSNumber? // (((UInt(myMessage.time! / 1000)) * 1000000000 ) + myMessage.timeNanos!) as NSNumber?
                        theMessage.uniqueId         = myMessage.uniqueId
                        if let messageConversation = myMessage.conversation {
                            if let conversationObject = updateCMConversationEntity(withConversationObject: messageConversation) {
                                theMessage.conversation = conversationObject
                            }
                        }
                        if let messageParticipant = myMessage.participant {
                            if let participantObject = updateCMParticipantEntity(inThreadId: myMessage.threadId!, withParticipantsObject: messageParticipant, isAdminRequest: false) {
                                theMessage.participant = participantObject
                            }
                        }
                        
                        if let messageForwardInfo = myMessage.forwardInfo {
                            if let conversation = messageForwardInfo.conversation {
                                if let thId = conversation.id {
                                    theMessage.forwardInfo = createCMForwardInfo(fromObject: messageForwardInfo, onThreadId: thId)
//                                    let forward = updateCMForwardInfoEntity(inThreadId: thId, withObject: messageForwardInfo)
//                                    theMessage.forwardInfo = forward
                                }
                            }
                        }
                        if let messageReplyInfo = myMessage.replyInfo {
                            theMessage.replyInfo = createCMReplyInfo(fromObject: messageReplyInfo, onThreadId: myMessage.threadId!)
//                            if let reply = updateCMReplyInfoEntity(inThreadId: myMessage.threadId!, withObject: messageReplyInfo) {
//                                theMessage.replyInfo = reply
//                            }
                        }
                        
                        messageObjectToReturn = theMessage
                        saveContext(subject: "Update CMMessage -create a new object-")
                        
                    }
                }
            } catch {
                fatalError("")
            }
        }
        return messageObjectToReturn
    }
    
    
//    // MARK: - update ReplyInfo:
//    func updateCMReplyInfoEntity(inThreadId threadId: Int, withObject myReplyInfo: ReplyInfo) -> CMReplyInfo? {
//        var replyInfoObjectToReturn: CMReplyInfo?
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMReplyInfo")
//        if let theTime = myReplyInfo.time {
//            fetchRequest.predicate = NSPredicate(format: "time == %i", theTime)
//        }
//        do {
//            if let result = try context.fetch(fetchRequest) as? [CMReplyInfo] {
//                if (result.count > 0) {
//                    result.first!.deletedd          = myReplyInfo.deleted as NSNumber?
//                    result.first!.message           = myReplyInfo.message
//                    result.first!.messageType       = myReplyInfo.messageType as NSNumber?
//                    result.first!.metadata          = myReplyInfo.metadata
//                    result.first!.repliedToMessageId    = myReplyInfo.repliedToMessageId as NSNumber?
//                    result.first!.systemMetadata    = myReplyInfo.systemMetadata
//                    result.first!.time              = myReplyInfo.time as NSNumber?
//                    if let participantObject = myReplyInfo.participant {
//                        if let participantObject = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: participantObject, isAdminRequest: false) {
//                            result.first!.participant = participantObject
//                        }
//                    }
//                    replyInfoObjectToReturn = result.first
//                    saveContext(subject: "Update CMReplyInfo -update existing object-")
//                } else {
//                    let theCMReplyInfo = NSEntityDescription.entity(forEntityName: "CMReplyInfo", in: context)
//                    let theReplyInfo = CMReplyInfo(entity: theCMReplyInfo!, insertInto: context)
//                    theReplyInfo.deletedd           = myReplyInfo.deleted as NSNumber?
//                    theReplyInfo.message            = myReplyInfo.message
//                    theReplyInfo.messageType        = myReplyInfo.messageType as NSNumber?
//                    theReplyInfo.metadata           = myReplyInfo.metadata
//                    theReplyInfo.repliedToMessageId = myReplyInfo.repliedToMessageId as NSNumber?
//                    theReplyInfo.systemMetadata     = myReplyInfo.systemMetadata
//                    theReplyInfo.time               = myReplyInfo.time as NSNumber?
//                    if let participantObject = myReplyInfo.participant {
//                        if let participantObject = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: participantObject, isAdminRequest: false) {
//                            theReplyInfo.participant = participantObject
//                        }
//                    }
//                    replyInfoObjectToReturn = theReplyInfo
//                    saveContext(subject: "Update CMReplyInfo -create a new object-")
//                }
//            }
//        } catch {
//            fatalError("")
//        }
//        return replyInfoObjectToReturn
//    }
//
//    // MARK: - update ForwardInfo:
//    func updateCMForwardInfoEntity(inThreadId threadId: Int, withObject myForwardInfo: ForwardInfo) -> CMForwardInfo? {
//        var forwardInfoObjectToReturn: CMForwardInfo?
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMForwardInfo")
//        do {
//            if let result = try context.fetch(fetchRequest) as? [CMForwardInfo] {
//                if (result.count > 0) {
//                    if let theParticipantObject = myForwardInfo.participant {
//                        if let participantObject = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: theParticipantObject, isAdminRequest: false) {
//                            result.first!.participant = participantObject
//                        }
//                    }
//                    if let theConversationObject = myForwardInfo.conversation {
//                        if let conversationObject = updateCMConversationEntity(withConversationObject: theConversationObject) {
//                            result.first!.conversation = conversationObject
//                        }
//                    }
//                    forwardInfoObjectToReturn = result.first
//                    saveContext(subject: "Update CMForwardInfo -update existing object-")
//                } else {
//                    let theCMForwardInfo = NSEntityDescription.entity(forEntityName: "CMForwardInfo", in: context)
//                    let theForwardInfo = CMForwardInfo(entity: theCMForwardInfo!, insertInto: context)
//
//                    if let theParticipantObject = myForwardInfo.participant {
//                        if let participantObject = updateCMParticipantEntity(inThreadId: threadId, withParticipantsObject: theParticipantObject, isAdminRequest: false) {
//                            theForwardInfo.participant = participantObject
//                        }
//                    }
//                    if let theConversationObject = myForwardInfo.conversation {
//                        if let conversationObject = updateCMConversationEntity(withConversationObject: theConversationObject) {
//                            theForwardInfo.conversation = conversationObject
//                        }
//                    }
//                    forwardInfoObjectToReturn = theForwardInfo
//                    saveContext(subject: "Update CMForwardInfo -create a new object-")
//                }
//            }
//        } catch {
//            fatalError("")
//        }
//        return forwardInfoObjectToReturn
//    }
    
    
    private func createCMReplyInfo(fromObject: ReplyInfo, onThreadId: Int) -> CMReplyInfo {
        let theCMReplyInfo = NSEntityDescription.entity(forEntityName: "CMReplyInfo", in: context)
        let theReplyInfo = CMReplyInfo(entity: theCMReplyInfo!, insertInto: context)
        theReplyInfo.deletedd           = fromObject.deleted as NSNumber?
        theReplyInfo.message            = fromObject.message
        theReplyInfo.messageType        = fromObject.messageType as NSNumber?
        theReplyInfo.metadata           = fromObject.metadata
        theReplyInfo.repliedToMessageId = fromObject.repliedToMessageId as NSNumber?
        theReplyInfo.systemMetadata     = fromObject.systemMetadata
        theReplyInfo.time               = fromObject.time as NSNumber?
        if let participantObject = fromObject.participant {
            if let participantObject = updateCMParticipantEntity(inThreadId: onThreadId, withParticipantsObject: participantObject, isAdminRequest: false) {
                theReplyInfo.participant = participantObject
            }
        }
        return theReplyInfo
    }
    
    private func createCMForwardInfo(fromObject: ForwardInfo, onThreadId: Int) -> CMForwardInfo {
        let theCMForwardInfo = NSEntityDescription.entity(forEntityName: "CMForwardInfo", in: context)
        let theForwardInfo = CMForwardInfo(entity: theCMForwardInfo!, insertInto: context)
        if let theParticipantObject = fromObject.participant {
            if let participantObject = updateCMParticipantEntity(inThreadId: onThreadId, withParticipantsObject: theParticipantObject, isAdminRequest: false) {
                theForwardInfo.participant = participantObject
            }
        }
        if let theConversationObject = fromObject.conversation {
            if let conversationObject = updateCMConversationEntity(withConversationObject: theConversationObject) {
                theForwardInfo.conversation = conversationObject
            }
        }
        return theForwardInfo
    }
    
    // MARK: - update PinMessage
    func updateCMPinMessageEntity(withObject myPinMessage: PinUnpinMessage) -> CMPinMessage? {
        var pinMessageObjectToReturn: CMPinMessage?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMPinMessage")
        fetchRequest.predicate = NSPredicate(format: "messageId == %i", myPinMessage.messageId)
        do {
            if let result = try context.fetch(fetchRequest) as? [CMPinMessage] {
                if (result.count > 0) {
                    if let messageId = myPinMessage.messageId as NSNumber? {
                        result.first!.messageId = messageId
                    }
                    if let notifyAll = myPinMessage.notifyAll as NSNumber? {
                        result.first!.notifyAll = notifyAll
                    }
                    if let text = myPinMessage.text {
                        result.first!.text = text
                    }
//                    result.first!.messageId = myPinMessage.messageId as NSNumber?
//                    result.first!.notifyAll = myPinMessage.notifyAll as NSNumber?
//                    result.first!.text      = myPinMessage.text
                    
                    pinMessageObjectToReturn = result.first
                    saveContext(subject: "Update CMPinMessage -update existing object-")
                } else {
                    let theCMPinMessage = NSEntityDescription.entity(forEntityName: "CMPinMessage", in: context)
                    let thePinMessage = CMPinMessage(entity: theCMPinMessage!, insertInto: context)
                    thePinMessage.messageId  = myPinMessage.messageId as NSNumber?
                    thePinMessage.notifyAll  = myPinMessage.notifyAll as NSNumber?
                    thePinMessage.text       = myPinMessage.text
                    
                    pinMessageObjectToReturn = thePinMessage
                    saveContext(subject: "Update CMPinMessage -create a new object-")
                }
            }
        } catch {
            fatalError("")
        }
        return pinMessageObjectToReturn
    }
    
    /*
    
    /*
     * Update ThreadParticipant Entity:
     *
     *
     *  + Access:   Private
     *  + Inputs:
     *      - threadId:         Int
     *      - participantId:    Int
     *  + Outputs:  _
     *
     */
    // update existing object or create new one
    func updateThreadParticipantEntity(inThreadId threadId: Int, withParticipantId participantId: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMThreadParticipants")
        fetchRequest.predicate = NSPredicate(format: "threadId == %i AND participantId == %i", threadId, participantId)
        do {
            if let result = try context.fetch(fetchRequest) as? [CMThreadParticipants] {
                if (result.count > 0) {
                    result.first!.time = Int(Date().timeIntervalSince1970) as NSNumber?
                    saveContext(subject: "Update CMThreadParticipants -update existing object-")
                } else {
                    let theCMThreadParticipants = NSEntityDescription.entity(forEntityName: "CMThreadParticipants", in: context)
                    let theThreadParticipants = CMThreadParticipants(entity: theCMThreadParticipants!, insertInto: context)
                    theThreadParticipants.threadId      = threadId as NSNumber?
                    theThreadParticipants.participantId = participantId as NSNumber?
                    theThreadParticipants.time          = Int(Date().timeIntervalSince1970) as NSNumber?
                    saveContext(subject: "Update CMThreadParticipants -create new object-")
                }
            }
        } catch {
            fatalError("Error on trying to find CMThreadParticipants")
        }
        
    }
    
    */
    
    
    
    
    
    
    
    
    
    // MARK: - update MessageGap:
    func updateMessageGapEntity(inThreadId threadId: Int, withMessageId messageId: Int, withPreviousId previousId: Int) {
        /*
         * -> fetch MessageGaps where their threadId is equal to input 'threadId'
         *      -> check if we found any object on the MessageGaps that is waiting for a messageId (its previousId property) that we have here on 'messageId'
         *          -> delete this object from MessageGaps Entity
         *      -> check if we have previouse message of this message on the gap or not
         *      -> check if we found the message on the MessageGaps, we will update its values
         *      -> otherwise we will create a MessageGaps object and assing input values to this object
         *
         */
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageGaps")
        fetchRequest.predicate = NSPredicate(format: "threadId == %i", threadId)
        do {
            if let result = try context.fetch(fetchRequest) as? [MessageGaps] {
                for item in result {
//                    // means that we found previousId of this message, so we have to delete this message from gap
//                    if ((item.previousId as? Int) == messageId) {
//                        deleteAndSave(object: item, withMessage: "Update MessageGaps -delete object-")
//                    }
                    if ((item.messageId as? Int) == messageId) {
                        item.previousId = previousId as NSNumber?
                        item.messageId  = messageId as NSNumber?
                        item.threadId   = threadId  as NSNumber?
                        saveContext(subject: "Update MessageGaps -update existing object-")
                    } else {
                        let theMessageGapsEntity = NSEntityDescription.entity(forEntityName: "MessageGaps", in: context)
                        let theMessageGap = MessageGaps(entity: theMessageGapsEntity!, insertInto: context)
                        theMessageGap.threadId      = threadId  as NSNumber?
                        theMessageGap.messageId     = messageId as NSNumber?
                        theMessageGap.previousId    = previousId as NSNumber?
                        saveContext(subject: "Update MessageGaps -create new object-")
                    }
                }
            }
        } catch {
            fatalError("Error on trying to find MessageGaps")
        }
        
    }
    
    
    
    // MARK: - update AllMessageGap:
    func updateAllMessageGapEntity(inThreadId threadId: Int) {
        /*
         *
         *  -> delete all messageGaps on threadId
         *  -> fetch all messages with 'threadId' Input
         *  -> lopp through it messages,
         *      -> if we found any message that it's previousId is not in the array, add it to the "gaps" array, to sendIt to 'saveMessageGap'
         *
         */
        deleteAllMessageGaps(inThreadId: threadId)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CMMessage")
        fetchRequest.predicate = NSPredicate(format: "threadId == %i", threadId)
        do {
            if let result = try context.fetch(fetchRequest) as? [CMMessage] {
                
                var gaps: (msgIds: [Int], prevIds: [Int]) = ([], [])
                
                for message in result {
                    for item in result {
                        var foundPrevious = false
                        if (message.previousId == item.id) {
                            foundPrevious = true
                        }
                        if !foundPrevious {
                            gaps.msgIds.append(message.id as! Int)
                            gaps.prevIds.append(message.previousId as! Int)
                        }
                    }
                }
                
                for (index, _) in gaps.msgIds.enumerated() {
                    updateMessageGapEntity(inThreadId: threadId, withMessageId: gaps.msgIds[index], withPreviousId: gaps.prevIds[index])
                }
//                saveMessageGap(threadId: threadId, messageIds: gaps.msgIds, messagePreviousIds: gaps.prevIds)
                
            }
        } catch {
            fatalError("Error on trying to find CMMessage")
        }
            
    }
 
    
}

