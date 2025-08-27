//
//  ServiceCall.swift
//  OnlineGrocery
//
//  Created by enesozmus on 17.08.2025.
//

import UIKit

class ServiceCall {
    
    class func post(
        parameter: NSDictionary,
        path: String,
        isToken: Bool = false,
        withSuccess: @escaping ( (_ responseObj: AnyObject?) ->() ),
        failure: @escaping ( (_ error: Error?) ->() ) )
    {
        DispatchQueue.global(qos: .userInitiated).async {
            let parameterData = NSMutableData()
            let dictKey = parameter.allKeys as! [String]
            
            var i=0;
            
            for dictKey in dictKey {
                if let values = parameter.value(forKey: dictKey) as? String {
                    parameterData.append(String.init(format: "%@%@=%@", i==0 ? "" : "&" ,dictKey, values.replacingOccurrences(of: "+", with: "%2B")).data(using: String.Encoding.utf8)!)
                } else {
                    parameterData.append(String.init(format: "%@%@=%@", i==0 ? "" : "&" ,dictKey, parameter.value(forKey: dictKey) as! CVarArg) .data(using: String.Encoding.utf8)!)
                }
                i += 1
            }
            
            
            var request = URLRequest(url: URL(string: path)!,timeoutInterval: 20)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if(isToken) {
#if DEBUG
                request.addValue("yqxaYDQV3pFjmgda1q15", forHTTPHeaderField: "access_token")
#else
                request.addValue(MainViewModel.shared.userObj.authToken, forHTTPHeaderField: "access_token")
#endif
                //yqxaYDQV3pFjmgda1q15
                //0ZbWMCJicXUFKfFh4JeM
            }
            request.httpMethod = "POST"
            request.httpBody = parameterData as Data
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                } else {
                    if let data = data {
                        do {
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                            
                            debugPrint("response : ", jsonDictionary ?? "JSON data not found! (ServiceCall- post method)")
                            
                            DispatchQueue.main.async {
                                withSuccess(jsonDictionary as AnyObject?)
                            }
                        }
                        catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    }
                }
                
                guard data != nil else {
                    return
                }
            }
            task.resume()
        }
    }
}
