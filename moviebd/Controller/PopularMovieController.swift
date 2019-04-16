//
//  ViewController.swift
//  moviebd
//
//  Created by Gabriel Soto valenzuela on 4/15/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import UIKit

class PopularMovieController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TablePopular: UITableView!
    @IBOutlet weak var LoadingViewPopular: UIActivityIndicatorView!
    
    var popularArray = [PopularMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TablePopular.delegate = self
        TablePopular.dataSource = self
        TablePopular.isUserInteractionEnabled = false
        
        startLoadingIndicator()
        getData()
    }
    
    func startLoadingIndicator() {
        LoadingViewPopular.startAnimating()
    }
    
    func stopLoadingIndicator() {
        LoadingViewPopular.alpha = 0
        LoadingViewPopular.stopAnimating()
    }
    
    func getData(){
        ServicioApi.getMovieOrderPopular{
            (moviePopular) in
            if let mTop = moviePopular {
                self.popularArray = mTop
                self.stopLoadingIndicator()
                self.TablePopular.reloadData()
                self.TablePopular.isUserInteractionEnabled = true
                print("count movie Popular ", self.popularArray.count)
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return popularArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellReuseId = "cellPopular"
        let peliTopRader = popularArray[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell
        
        let s = String(describing: peliTopRader.title)
        cell.textLabel?.text = s
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let userIdentityString : NSString? = popularArray[indexPath.row].poster_path
        
        self.performSegue(withIdentifier: "segueDetailPopular", sender: userIdentityString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailPopular"
        {
            if let id = TablePopular.indexPathForSelectedRow
            {
                let fila = popularArray[id.row]
                let destino = segue.destination as! DetailMovieController
                destino.poster_path = fila.poster_path
                destino.overview = fila.overview
                
                if let index = self.TablePopular.indexPathForSelectedRow
                {
                    self.TablePopular.deselectRow(at: index, animated: true)
                }
                
            }
        }
    }
}
