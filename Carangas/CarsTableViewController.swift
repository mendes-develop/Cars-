//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Alex Mendes on 05/24/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    
    var cars: [Car] = []
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        return label
    }()
    
    override func viewDidLoad() {
        label.text = "Loading Cars..."
        super.viewDidLoad()

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        REST.loadCars(onComplete: { (cars) in
            
            self.cars = cars
            DispatchQueue.main.async {
                self.label.text = "No cars saved"
                self.tableView.reloadData()
            }
            
            
            
        }) { (error) in
            print(error)
//            switch error {
    //            case .invalidJSON:
    //                    print("Invalid JSON")
    //            case .noData:
    //                    print("No Data")
    //            case .noResponse:
    //                    print("No response")
    //            case .responseStatusCode(code: Int):
    //                print("Status code \(code)")
    //            case .taskError(error: error):
    //                print("Task error: \(error)")
    //            case .url:
    //                print("Invalid URL")
    //            default:
    //                break
//            }
        }
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = cars.count == 0 ? label : nil
        return cars.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
     
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
     
     return cell
     }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue" {
           let vc = segue.destination as! CarViewController
            vc.car = cars[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let car = cars[indexPath.row]
            
            REST.delete(car: car) { (success) in
                if success {
                    
                    self.cars.remove(at: indexPath.row)
                    
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
}
