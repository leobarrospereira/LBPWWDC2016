//
//  VideoServicesContract.swift
//  LBPWWDC2016
//
//  Created by Leonardo Barros on 28/09/2016.
//  Copyright © 2016 Leonardo Barros. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case error(Error)
    case data([T])
}

protocol VideoServicesContract {
    
    func getVideos(completion: @escaping (ServiceResult<Video>) -> Void)
    
}
