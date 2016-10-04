//
//  VideosServices.swift
//  LBPWWDC2016
//
//  Created by Leonardo Barros on 28/09/2016.
//  Copyright © 2016 Leonardo Barros. All rights reserved.
//

import Foundation

struct VideoServices {
    
    let networkingManager: NetworkingManagerContract
    
    init(networkingManager: NetworkingManagerContract) {
        self.networkingManager = networkingManager
    }
    
}

extension VideoServices: VideoServicesContract {
    
    func getVideos(completion: @escaping (ServiceResult<Video>) -> Void) {
        let url = URL(string: "https://devimages-cdn.apple.com/wwdc-services/g7tk3guq/xhgbpyutb6wvn2xcrbcz/videos.json")
        
        networkingManager.getData(with: url!) { (data, urlResponse, error) in
            if let error = error {
                completion(ServiceResult.error(error))
                return
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let sessionsArray = json?["sessions"] as? [[String: Any]] else {
                    let error = NSError(domain: "com.leonardobarros.LBPWWDC2016", code: -1, userInfo: [NSLocalizedDescriptionKey: "Wrong data"])
                    completion(ServiceResult.error(error))
                    return
            }
            
            let videos = sessionsArray.flatMap { Video(json: $0) }
            completion(ServiceResult.data(videos))
        }
    }
    
}

extension Video {
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
            let title = json["title"] as? String,
            let images = json["images"] as? [String: Any],
            let imageUrlString = images["shelf"] as? String, let imageUrl = URL(string: imageUrlString),
            let videoUrlString = json["url"] as? String, let videoUrl = URL(string: videoUrlString),
            let platforms = json["focus"] as? [String] else {
                print("Wrong dictionary to create Video \(json)")
                return nil
        }
        
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.platforms = platforms
    }
    
}
