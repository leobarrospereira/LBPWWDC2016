//
//  URLSession+NetworkingManagerContract.swift
//  LBPWWDC2016
//
//  Created by Leonardo Barros on 28/09/2016.
//  Copyright © 2016 Leonardo Barros. All rights reserved.
//

import UIKit

// MARK: - URLSessionManagerContract

extension URLSession: NetworkingManagerContract {
    
    func getData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
    
}
