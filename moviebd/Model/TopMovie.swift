//
//  TopMovie.swift
//  moviebd
//
//  Created by Gabriel Soto valenzuela on 4/15/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import Foundation

struct TopMovie
{
    
    let original_title: NSString?
    let title: NSString?
    let poster_path: NSString?
    let overview: NSString?
    
    
    init(dictionary: [String:AnyObject])
    {
        
        self.original_title = dictionary["original_title"] as? NSString
        self.title = dictionary["title"] as? NSString
        self.poster_path = dictionary["poster_path"] as? NSString
        self.overview = dictionary["overview"] as? NSString
    }
}
