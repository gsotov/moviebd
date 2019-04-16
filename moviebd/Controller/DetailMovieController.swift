//
//  DetailMovieController.swift
//  moviebd
//
//  Created by Gabriel Soto valenzuela on 4/15/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class DetailMovieController: UIViewController {
    
    @IBOutlet weak var imagenDetalle: UIImageView!
    @IBOutlet weak var textoDetalle: UILabel!
    @IBOutlet weak var LoadingDetailView: UIActivityIndicatorView!
    
    
    
    var delegate: PopularMovieController?
    var delegate2: PopularMovie?
    
    var poster_path: NSString?
    var overview: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = String(describing: poster_path)
        self.getDetallePelicula(poster_path: path)
        
        startLoadingIndicator()
    }
    
    func startLoadingIndicator() {
        LoadingDetailView.startAnimating()
    }
    
    func stopLoadingIndicator() {
        LoadingDetailView.alpha = 0
        LoadingDetailView.stopAnimating()
    }
    
    func getDetallePelicula(poster_path:String){
        
        let urlKey = "http://image.tmdb.org/t/p/w500"+poster_path.replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "Optional(", with: "")
        if let url = URL(string: urlKey){
            
            do {
                let s = String(describing: overview)
                self.textoDetalle.text = s
                
                let data = try Data(contentsOf: url)
                self.imagenDetalle.image = UIImage(data: data)
                
                self.stopLoadingIndicator()
                
            }catch let err {
                print(" Error : \(err.localizedDescription)")
            }
            
            
        }
    }
      
    
    @IBAction func volver(_ sender: UIButton) {
        self.performSegue(withIdentifier: "volverInicio", sender: nil)
    }
}
