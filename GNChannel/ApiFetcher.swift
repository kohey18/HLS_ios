//
//  ApiFetcher.swift
//  GNChannel
//
//  Created by kohey on 2015/07/19.
//  Copyright (c) 2015年 kohey. All rights reserved.
//

//import Cocoa

typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

public class ApiFetcher: NSObject {
    
    var apiRootURL = "http://52.68.112.82:3000"
    
    let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    let serializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
    
    func getLives(onCompletion: ServiceResponse) -> Void {
        self.manager.requestSerializer = serializer
        self.manager.GET(self.apiRootURL + "/live", parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseDict = responseObject as! NSDictionary
                onCompletion(responseDict, nil)
            },
            failure: {(operation: AFHTTPRequestOperation?, error: NSError!) in
                onCompletion(nil, error)
            }
        )
        
     }
    
    func getUsers(onCompletion: ServiceResponse) -> Void {
        self.manager.requestSerializer = serializer
        self.manager.GET(self.apiRootURL + "/users", parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseDict = responseObject as! NSDictionary
                onCompletion(responseDict, nil)
            },
            failure: {(operation: AFHTTPRequestOperation?, error: NSError!) in
                onCompletion(nil, error)
            }
        )
        
    }
    
    func getLive(userId: NSString, onCompletion: ServiceResponse) -> Void {
        self.manager.requestSerializer = serializer
        let liveUrl:String = "/live/\(userId)"
        self.manager.GET(self.apiRootURL + liveUrl, parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let responseDict = responseObject as! NSDictionary
                onCompletion(responseDict, nil)
            },
            failure: {(operation: AFHTTPRequestOperation?, error: NSError!) in
                onCompletion(nil, error)
            }
        )
        
    }

    
    func postLive(live: NSDictionary) -> Void {
        self.manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject>
        self.manager.POST(self.apiRootURL + "/live/new", parameters: live,
            success: {(operation: AFHTTPRequestOperation!, responsobject: AnyObject!) in
            },
            failure: {(operation: AFHTTPRequestOperation?, error: NSError!) in
            }
        )
    }
}
