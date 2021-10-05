//
//  NetworkController.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import Foundation
import UIKit

class NetworkController: NSObject {

    lazy var protectedSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()


    lazy var publicSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    

    // MARK: -
    // MARK: Singleton

    static var shared: NetworkController = {
        struct StaticInstance {
            static let instance = NetworkController()
        }
        return StaticInstance.instance
    }()
    
    // MARK: -
    // MARK: Network Activity Indicator

    var networkRequests = 0
    var networkTimeoutTimer: Timer?
}

extension NetworkController {

    public func fetchAvailableCities(completionBlock: @escaping (_ cities: [City]?) -> ()) {
        
        //TODO: Network call here
        if let jsonData = JsonHelper.readLocalFile(forName: "crowded") {
            // Decode the json data to a Candidate struct
            let business = try? JSONDecoder().decode([Business].self, from: jsonData)
            
            guard let allCities = business?.map({$0.businessAddress.city.capitalized}) else { completionBlock(nil); return }

            let mapped = allCities.unique().map({City(name: $0)})
            
            completionBlock(mapped)
            
        }
    }
    
    public func fetchBusinessess(in city: String?, completionBlock: @escaping (_ image: [Business]?) -> ()) {
        
        //TODO: Network call here
        if let jsonData = JsonHelper.readLocalFile(forName: "crowded") {
            // Decode the json data to a Candidate struct
            let business = try? JSONDecoder().decode([Business].self, from: jsonData)
            if let city = city {
                completionBlock(business?.filter({$0.businessAddress.city.contains(city)}))
                return
            }
            completionBlock(business)
        }
    }
    
    public func requestImage(_ url: URL, completionBlock: @escaping (_ image: UIImage?) -> ()) {
        // Return cached image
        let fileName = UUID().uuidString
        let filePath = NSTemporaryDirectory() + fileName
        if let image = UIImage(contentsOfFile: filePath) {
            completionBlock(image)
            return
        }

        // Start network request
        let request = URLRequest(url: url)
        let task = self.publicSession.dataTask(with: request) { data, _, error in
         
            if let imageData = data, let image = UIImage(data: imageData) {
                try? imageData.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
                completionBlock(image)
            } else {
                completionBlock(nil)
            }
        }
        task.resume()
    }
}

// MARK: -
// MARK: NSURLSessionDelegate

extension NetworkController: URLSessionDelegate {
   
}


// MARK: -
// MARK: URLSessionTaskDelegate

extension NetworkController: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
   
    }
}
