//
//  ListSongViewController.swift
//  MusicFind
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 maurisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ListSongViewController: UITableViewController {

  var songs = [Song]()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Configuraciones de UI
    tableView.registerNib(UINib(nibName: "SongCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "SongCell")

    getSongs()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  // MARK: - Consumir el API para obtener las canciones

  func getSongs() {
    Alamofire.request(.GET, "https://itunes.apple.com/search?term=beatles&entity=song&limit=20", parameters: nil)
      .responseJSON { response in

        if response.result.error == nil {
          debugPrint("respuesta server : \(response.result.value)")
          let json = JSON(response.result.value!)
          self.songs = Song.songsByJSON(json["results"])
          debugPrint("canciones : \(self.songs)")

          self.tableView.reloadData()
        } else {
          debugPrint("error : \(response.result.error)")
          self.showAlertMessage(response.result.error!.localizedDescription)
        }

      }
  }


  func showAlertMessage(message: String) {
    let alert = UIAlertController(title: "MusicFing", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Joder !", style: UIAlertActionStyle.Cancel, handler: nil))
    presentViewController(alert, animated: true, completion: nil)
  }


  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return songs.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath) as! SongCell

    let song = self.songs[indexPath.row]
    // Configure the cell...
    cell.songLabel.text = song.songName
    cell.albumArtistLabel.text = song.songInformation()
    cell.coverImageView.sd_setImageWithURL(song.imageUrl, placeholderImage: nil)
    cell.genreLabel.text = song.genreInformation()
    cell.priceLabel.text = song.priceInformation()

    return cell
  }

  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the specified item to be editable.
  return true
  }
  */

  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */

  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the item to be re-orderable.
  return true
  }
  */

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */

}
