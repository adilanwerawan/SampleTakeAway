//
//  AFWrapper.swift
//  SampleSwiftApp
//
//  Created by Adil Anwer on 7/4/17.
//  Copyright © 2017 Adil Anwer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import Foundation

class AFWrapper: NSObject {
    
    //MARK: constant and variable
    //manager
    public var alamoFireManager: Alamofire.SessionManager!
    public var failureMessage = "Unable to connect to the internet"
    //network
    
    public var commonHeaders: Dictionary<String, String> = [
        "Authorization": "",
        "Accept": "application/json",
        "X-Requested-With": "XMLHttpRequest"
    ]
    
    let nvSpinnerSize = CGSize(width: 50, height: 50)
    let nvSpinner = NVLoader()
    
    //shared Instance
    public static let shared: AFWrapper = {
        let instance = AFWrapper()
        
        return instance
    }()
    
    //Get file base url from local
    public func getBaseURL() -> String{
        
        let jsonFileURL = Bundle.main.url(forResource: "SampleiOS", withExtension: ".json", subdirectory: "Assets")
        if jsonFileURL != nil{
            
            return jsonFileURL?.absoluteString ?? ""
        }
        
        return ""
    }
    
    // MARK: - : override
    override init() {
        alamoFireManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 120
    }
    
    //setupSSL
//    public func setupSSLPinning(_ fileNameInBundle: String) {
//        
//        // Set up certificates
//        let pathToCert = Bundle.main.path(forResource: fileNameInBundle, ofType: "crt")
//        let localCertificate = NSData(contentsOfFile: pathToCert!)
//        let certificates = [SecCertificateCreateWithData(nil, localCertificate!)!]
//        
//        // Configure the trust policy manager
//        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
//            certificates: certificates,
//            validateCertificateChain: true,
//            validateHost: true
//        )
//        
//        let serverTrustPolicies = [
//            AFWrapper.shared.baseURL.getDomain() ?? AFWrapper.shared.baseURL : serverTrustPolicy
//        ]
//        
//        alamoFireManager =
//            Alamofire.SessionManager(
//                configuration: URLSessionConfiguration.default,
//                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//    }
}

extension AFWrapper {
    
    //Set access token on authorization
    public func setAccessTokenOnAuthorization(accessToken: String) {
        
        self.commonHeaders["Authorization"] = accessToken
    }
    
    //general request
    public func apiRequest(_ info: AFParam, isSpinnerNeeded: Bool, success:@escaping (Any?) -> Void, failure:@escaping (Error) -> Void) {
        
        //if spinner needed
        if isSpinnerNeeded {
            DispatchQueue.main.async {
                AFWrapper.shared.showSpinner()
            }
        }
        
        //URLEncoding(destination: .methodDependent)
        //request
        let baseURL = self.baseURL + info.endpoint
        let headers = mergeWithCommonHeaders(info.headers)
        let paramEncoding = info.parameterEncoding
        alamoFireManager.request(baseURL,method:info.method,parameters:info.params,encoding:paramEncoding,headers:headers).responseJSON { (response) -> Void in
            
            //remove spinner
            if isSpinnerNeeded {
                DispatchQueue.main.async {
                    AFWrapper.shared.hideSpinner()
                }
            }
            
            //check response result case
            switch response.result {
            case .success:
                
                print("------------------------------------------------RESPONSE---------------------------------------------\n")
                
//                if let data = response.result.value{
//                    let json = JSON(data)
//                }
                
                if let responseDic: Dictionary<String,Any> = response.result.value as? [String: Any] {
                    
                    debugPrint(responseDic.printJson())
                    
                    if (responseDic["error"] != nil) {
                        
                        success(responseDic)
                        print("\n***********************************************************************************************\n\n\n\n")
                    } else if responseDic["message"] != nil {
                        
                        success(responseDic)
                    } else {
                        
                        success(response.data)
                    }
                } else {
                    
                     success(response.data)
                }
               
            case .failure:
                let error: Error = response.result.error!
                debugPrint("\n\nresponseError:\n\n \(error)")
                DispatchQueue.main.async {
                    Alert.showMsg(msg: error.localizedDescription)
                }
                failure(error)
            }
        }
        print("------------------------------------SERVICE DETAILS---------------------------------------")
        print("\n\n************************PARAMS DICTIONARY JSON*********************:\n\n")
        debugPrint(info.params?.printJson() ?? "")
    }
    
    //general request
    public func apiRequestSwiftyJson(_ info: AFParam, isSpinnerNeeded: Bool, success:@escaping (Any?) -> Void, failure:@escaping (Error) -> Void) {
        
        //if spinner needed
        if isSpinnerNeeded {
            DispatchQueue.main.async {
                AFWrapper.shared.showSpinner()
            }
        }
        //URLEncoding(destination: .methodDependent)
        //request
        alamoFireManager.request(self.baseURL + info.endpoint, method: info.method, parameters: info.params, encoding: info.parameterEncoding, headers: mergeWithCommonHeaders(info.headers)).responseJSON { (response) -> Void in
            
            //remove spinner
            if isSpinnerNeeded {
                DispatchQueue.main.async {
                    AFWrapper.shared.hideSpinner()
                }
            }
            
            //check response result case
            switch response.result {
            case .success:
                
                print("------------------------------------------------RESPONSE---------------------------------------------\n")
                
                //                if let data = response.result.value{
                //                    let json = JSON(data)
                //                }
                
                if let responseDic: Dictionary<String,Any> = response.result.value as? [String: Any] {
                    
                    debugPrint(responseDic.printJson())
                    
                    if (responseDic["errors"] != nil) {
                        
                        success(responseDic)
                        print("\n***********************************************************************************************\n\n\n\n")
                    } else {
                        
                        if let data = response.result.value {
                            let json = JSON(data)
                            success(json)
                        }
                    }
                } else {
                    
                    if let data = response.result.value {
                        let json = JSON(data)
                        success(json)
                    }
                }
                
            case .failure:
                let error: Error = response.result.error!
                debugPrint("\n\nresponseError:\n\n \(error)")
                DispatchQueue.main.async {
                    Alert.showMsg(msg: error.localizedDescription)
                }
                failure(error)
            }
        }
        print("------------------------------------SERVICE DETAILS---------------------------------------")
        print("\n\n************************PARAMS DICTIONARY JSON*********************:\n\n")
        debugPrint(info.params?.printJson() ?? "")
    }
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        //        presenter.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue:  6)!)
        
        DispatchQueue.main.async {
            
            AFWrapper.shared.showSpinner()
        }
        
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            //            presenter.stopAnimating()
            DispatchQueue.main.async {
                AFWrapper.shared.hideSpinner()
            }
            print(responseObject)
            
            if responseObject.result.isSuccess {
                //                let resJson = JSON(responseObject.result.value!)
                
                if let data = responseObject.result.value {
                    let json = JSON(data)
                    success(json)
                }
                
                //                success(resJson)
            }
            if responseObject.result.isFailure {
                let error: Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    class func requestPOSTURL(_ strURL: String, params: [String: AnyObject]?, headers: [String: String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        DispatchQueue.main.async {
            AFWrapper.shared.showSpinner()
        }
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            DispatchQueue.main.async {
                AFWrapper.shared.hideSpinner()
            }
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error: Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    //return merge headers
    func mergeWithCommonHeaders(_ headers: [String: String]?) -> Dictionary<String, String> {
        
        if headers != nil {
            for header in headers! {
                AFWrapper.shared.commonHeaders[header.key] = header.value
            }
        }
        return AFWrapper.shared.commonHeaders
    }
}

//Mark : - Show and hide spinner and progress methods
extension AFWrapper {
    
    func showSpinner() {
        
//        nvSpinner.startAnimating(nvSpinnerSize, message: "Loading...", type: NVActivityIndicatorType(rawValue:  6)!)
        nvSpinner.startAnimating(nvSpinnerSize, message: "Loading...")
    }
    
    func hideSpinner() {
        
        nvSpinner.stopAnimating()
    }
}

class NVLoader: UIViewController, NVActivityIndicatorViewable { }

extension Dictionary {
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
}
