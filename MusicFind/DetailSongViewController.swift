//
//  DetailSongViewController.swift
//  MusicFind
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 maurisoft. All rights reserved.
//

import UIKit
import SDWebImage

class DetailSongViewController: UIViewController {

  // outlets
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var songLabel: UILabel!
  @IBOutlet weak var coverImageView: UIImageView!

  var song: Song?

  override func viewDidLoad() {
    super.viewDidLoad()

    if let song = song {
      artistLabel.text = song.artistName
      songLabel.text = song.songName
      let imageUrl = NSURL(string: song.imageUrl)
      coverImageView.sd_setImageWithURL(imageUrl, placeholderImage: nil)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}
