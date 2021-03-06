//
//  UploadImageModel.swift
//  Chat
//
//  Created by Mahyar Zhiani on 8/5/1397 AP.
//  Copyright © 1397 Mahyar Zhiani. All rights reserved.
//

import Foundation
import SwiftyJSON

open class UploadImageModel {
    /*
     ---------------------------------------
     * responseAsJSON:
     *  - hasError          Bool
     *  - errorMessage      String
     *  - errorCode         Int
     *  + result       JSON or UploadImageModel:
     *      + UploadImage   UploadImageAsJSON:
     *          - actualHeight  Int?
     *          - actualWidth   Int?
     *          - hashCode      String?
     *          - height        Int?
     *          - id            Int?
     *          - name          String?
     *          - width         Int?
     ---------------------------------------
     * responseAsModel:
     *  - hasError          Bool
     *  - errorMessage      String
     *  - errorCode         Int
     *  + user              User
     ---------------------------------------
     */
    
    // uploadImage model properties
    public let errorCode:           Int
    public let errorMessage:        String
    public let hasError:            Bool
    //    public var localPath:           String = ""
    public let uploadImage:         ImageObject?
    
    public init(messageContentJSON: JSON?,
                errorCode:      Int,
                errorMessage:   String,
                hasError:       Bool/*,
         localPath:      String?*/) {
        
        self.hasError           = hasError
        self.errorMessage       = errorMessage
        self.errorCode          = errorCode
        
        //        if let pathString = localPath {
        //            self.localPath = pathString
        //        }
        
        if let content = messageContentJSON {
            self.uploadImage = ImageObject(messageContent: content)
        } else {
            uploadImage = nil
        }
        
    }
    
    public init(messageContentModel: ImageObject?,
                errorCode:      Int,
                errorMessage:   String,
                hasError:       Bool/*,
         localPath:      String?*/) {
        
        self.hasError           = hasError
        self.errorMessage       = errorMessage
        self.errorCode          = errorCode
        
        //        if let pathString = localPath {
        //            self.localPath = pathString
        //        }
        
        if let myImage = messageContentModel {
            self.uploadImage    = myImage
        } else {
            uploadImage = nil
        }
    }
    
    
    public func returnDataAsJSON() -> JSON {
        let result: JSON = ["uploadImage":      uploadImage?.formatToJSON() ?? NSNull()]
        
        let resultAsJSON: JSON = ["result":     result,
                                  "errorCode":  errorCode,
                                  "errorMessage": errorMessage,
                                  "hasError":   hasError/*,
             "localPath": localPath*/]
        
        return resultAsJSON
    }
    
    
    func returnMetaData(onServiceAddress: String) -> JSON {
        var imageMetadata : JSON = [:]
        
        if let upload = uploadImage {
            let link = "\(onServiceAddress)\(SERVICES_PATH.GET_IMAGE.rawValue)?imageId=\(upload.id)&hashCode=\(upload.hashCode)"
            imageMetadata["link"]            = JSON(link)
            imageMetadata["id"]              = JSON(upload.id)
            imageMetadata["name"]            = JSON(upload.name ?? "")
            imageMetadata["height"]          = JSON(upload.height ?? 0)
            imageMetadata["width"]           = JSON(upload.width ?? 0)
            imageMetadata["actualHeight"]    = JSON(upload.actualHeight ?? 0)
            imageMetadata["actualWidth"]     = JSON(upload.actualWidth ?? 0)
            imageMetadata["hashCode"]        = JSON(upload.hashCode)
        }
        
        return imageMetadata
    }
    
}

