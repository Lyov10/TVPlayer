//
//  VideoViewController.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import UIKit
import Foundation
import AVFoundation



class VideoViewController: UIViewController {
    
    @IBOutlet weak var videoView: PlayerView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var qualityContainerView: UIView!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var progresBar: GradientProgressView!
    
    var chanelModel: ChannelModel?
    private  var videoPlayer:VideoPlayer?
    weak var timer : Timer?
    var timeCount: TimeInterval = 30
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupProgressBar()
        setupMoviePlayer()
    }
    
    private func setupProgressBar() {
        self.progresBar.setProgress(0.0, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.progresBar.setProgress(1.0, animated: false)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            UIView.animate(withDuration: self.timeCount, delay: 0, options: [], animations: { [unowned self] in
                self.progresBar.layoutIfNeeded()
            })
        }
    }
    
    func setupMoviePlayer(){
        guard let url = NSURL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4") else {return}
        videoPlayer = VideoPlayer(urlAsset: url, view: videoView)
        videoPlayer?.play()

      }
    
    private func setupView() {
        guard let chanelModel = chanelModel else {return}
        channelImage.layer.cornerRadius = 4
        programName.text = chanelModel.current.title
        descriptionLabel.text = chanelModel.name
        guard let url = URL(string: chanelModel.image) else {return}
        channelImage.downloaded(from: url)
        qualityContainerView.layer.cornerRadius = 12
    }
    
    @objc func updateTimer() {
        if timeCount > 0 {
            timeCount -= 1
            minuteLabel.text = "Осталось \(Int(timeCount)) минут"
        } else {
            minuteLabel.text = ""
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingsButtonTaped(_ sender: Any) {
        self.qualityContainerView.isHidden = !self.qualityContainerView.isHidden
    }
}

