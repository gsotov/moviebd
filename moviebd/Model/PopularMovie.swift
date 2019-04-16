//
//  PopularMovie.swift
//  moviebd
//
//  Created by Gabriel Soto valenzuela on 4/15/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import Foundation

struct PopularMovie
{
    
    let original_title: NSString?
    let title: NSString?
    let poster_path: NSString?
    let overview: NSString?
    
    init(original_title: NSString, title: NSString, poster_path: NSString, overview: NSString)
    {
        self.original_title = original_title
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
    }
    
    init(dictionary: [String:AnyObject])
    {
        
        self.original_title = dictionary["original_title"] as? NSString
        self.title = dictionary["title"] as? NSString
        self.poster_path = dictionary["poster_path"] as? NSString
        self.overview = dictionary["overview"] as? NSString
    }
    
}
