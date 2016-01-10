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
  var songSelected: Song?

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
    let imageUrl = NSURL(string: song.imageUrl)
    cell.coverImageView.sd_setImageWithURL(imageUrl, placeholderImage: nil)
    cell.genreLabel.text = song.genreInformation()
    cell.priceLabel.text = song.priceInformation()

    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.songSelected = self.songs[indexPath.row]
    self.performSegueWithIdentifier("showSongSegue", sender: nil)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showSongSegue" {
      let detailSongVC = segue.destinationViewController as! DetailSongViewController
      detailSongVC.song = self.songSelected
    }
  }

}
