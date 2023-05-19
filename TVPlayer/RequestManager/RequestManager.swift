//
//  RequestManager.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import Foundation

class RequestManager {
    static let  sharedInstance = RequestManager()
    
    private init() {  }
    
    func getChanells(completion: @escaping (_ response: ChanellList) -> Void) {
        let url = URL(string: "http://limehd.online/playlist/channels.json")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                 
                 guard error == nil else {
                     print("Error fetching data from server\nERROR: \(String(describing: error))")
                     return
                 }
                 
                 guard let jsonData = data else {
                     print("Response Data is empty")
                     return
                 }
                                  
                 let decoder = JSONDecoder()
                 let response = try? decoder.decode(ChanellList.self, from: jsonData)
                 
                 guard let decodedResponse = response else {
                     print("Unable to parse data from response")
                     return
                 }
                 
                 print("Decoded Response: ", decodedResponse)
                 
                 DispatchQueue.main.async { completion(decodedResponse) }
             }
             
             task.resume()
         }
    }

