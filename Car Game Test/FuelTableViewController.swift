//
//  FuelTableViewController.swift
//  Car Game Test
//
//  Created by Daniel on 25/3/19.
//  Copyright © 2019 Placeholder Interactive. All rights reserved.
//

import UIKit
import AVFoundation
var fuelType = 0
var player: AVAudioPlayer?

class FuelTableViewController: UITableViewController {

    @IBOutlet var mainTable: UITableView!
    
    @IBOutlet weak var choosePetrol: UIButton!
    @IBOutlet weak var chooseBio: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var bioPriceLabe: UILabel!
    
    var biofuelPrice = 1000

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if equippedCar == "missan" || equippedCar == "lazus" {
            biofuelPrice = 1000
        } else {
            biofuelPrice = 750
            bioPriceLabe.text = "\(biofuelPrice) POINTS"
        }
        pointsLabel.text = "Points: \(totalPts)"
        mainTable.allowsSelection = false
        choosePetrol.layer.cornerRadius = 5
        chooseBio.layer.cornerRadius = 5
        if totalPts >= biofuelPrice {
            chooseBio.isUserInteractionEnabled = true
            
            chooseBio.setTitle("CHOOSE", for: .normal)
            chooseBio.backgroundColor = UIColor(red:0.36, green:0.71, blue:1.00, alpha:1.0)
            chooseBio.setTitleColor(UIColor(red:1.00, green:1.00, blue:0.94, alpha:1.0), for: .normal)
        } else {
            chooseBio.isUserInteractionEnabled = false
            
            chooseBio.setTitle("NOT ENOUGH", for: .normal)
            chooseBio.backgroundColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
            chooseBio.titleLabel?.font = UIFont(name: "Chalkduster", size: 18)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.pause()
            playBackgroundMusic(filename: "themera.mp3")
        } else {
            playBackgroundMusic(filename: "themera.mp3")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    @IBAction func petrol(_ sender: Any) {
        fuelType = 0
    }
    
    @IBAction func biofuel(_ sender: Any) {
        totalPts -= biofuelPrice
        fuelType = 1
        UserDefaults.standard.set(totalPts, forKey: "totalPts")
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
     
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func playBackgroundMusic(filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: newURL)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            player?.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}
