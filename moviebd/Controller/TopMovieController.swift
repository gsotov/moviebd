//
//  TopMovieController.swift
//  moviebd
//
//  Created by Gabriel Soto valenzuela on 4/15/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import Foundation
import UIKit

class TopMovieController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var TopTable: UITableView!
    @IBOutlet weak var LoadingViewTop: UIActivityIndicatorView!
    
    var topArray = [TopMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TopTable.delegate = self
        TopTable.dataSource = self
        
        startLoadingIndicator()
        getDataTopMovie()
    }
    
    func startLoadingIndicator() {
        LoadingViewTop.startAnimating()
    }
    
    func stopLoadingIndicator() {
        LoadingViewTop.alpha = 0
        LoadingViewTop.stopAnimating()
    }
    
    func getDataTopMovie(){
        ServicioApi.getMovieOrderTop { (movieTop) in
            if let mTop = movieTop {
                self.topArray = mTop
                self.stopLoadingIndicator()
                self.TopTable.reloadData()
                print("count peliculas ", self.topArray.count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return topArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellReuseId = "cellTop"
        let peliTopRader = topArray[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell
        
        let s = String(describing: peliTopRader.title)
        cell.textLabel?.text = s
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "segueDetailTop", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailTop"{
            if let id = TopTable.indexPathForSelectedRow
            {
                let fila = topArray[id.row]
                
                let controller = segue.destination as! DetailMovieController
                controller.poster_path = fila.poster_path
                controller.overview = fila.overview
                
                if let index = self.TopTable.indexPathForSelectedRow
                {
                    self.TopTable.deselectRow(at: index, animated: true)
                }
                
            }
        }
    }
}
