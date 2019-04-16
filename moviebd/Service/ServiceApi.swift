//
//  ServiceApi.swift
//  moviebd
//
//  Created by Gabriel Soto valenzuela on 4/15/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Clase que consume las API de moviebd
class ServicioApi : NSObject
{
    //Clase que consume api de peliculas ordenadas por polular
    class func getMovieOrderPopular(completion: @escaping (_ PopularMovie: [PopularMovie]?) -> ()){
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44"
        
        Alamofire.request(url).responseJSON
            {
                response in
                
                let _PopularMovie: NSMutableArray = []
                switch response.result{
                case .failure( _):
                    if let data = response.data{
                        print("Server error  " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    completion(nil)
                    
                case .success(let value):
                    let json = JSON(value)
                    
                    for current in JSON(json)["results"].arrayValue{
                        _PopularMovie.add(PopularMovie(dictionary: (current.dictionaryObject! as NSDictionary) as! [String:AnyObject]))
                    }
                    completion(_PopularMovie as NSArray as? [PopularMovie])
                }
                
        }
    }
    
    //Clase que consume api de peliculas ordenadas películas por top rated
    class func getMovieOrderTop(completion: @escaping (_ peliculaTop: [TopMovie]?) -> ()){
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=34738023d27013e6d1b995443764da44"
        
        Alamofire.request(url).responseJSON { response in
            let _MovieTop: NSMutableArray = []
            switch response.result{
            case .failure( _):
                if let data = response.data{
                    print("Server error  " + String(data: data, encoding: String.Encoding.utf8)!)
                }
                completion(nil)
                
            case .success(let value):
                let json = JSON(value)
                
                for current in JSON(json)["results"].arrayValue{
                    _MovieTop.add(TopMovie(dictionary: (current.dictionaryObject! as NSDictionary) as! [String:AnyObject]))
                }
                completion(_MovieTop as NSArray as? [TopMovie])
            }
        }
    }
}
