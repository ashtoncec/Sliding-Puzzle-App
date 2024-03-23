//
//  ViewController.swift
//  Ind02_Cecil_Ashton
//
//  Created by Ashton Cecil on 2/26/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!
    @IBOutlet weak var imageView11: UIImageView!
    @IBOutlet weak var imageView12: UIImageView!
    @IBOutlet weak var imageView13: UIImageView!
    @IBOutlet weak var imageView14: UIImageView!
    @IBOutlet weak var imageView15: UIImageView!
    @IBOutlet weak var imageView16: UIImageView!
    @IBOutlet weak var imageView17: UIImageView!
    @IBOutlet weak var imageView18: UIImageView!
    @IBOutlet weak var imageView19: UIImageView!
    @IBOutlet weak var imageView20: UIImageView!
    
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var answerButton: UIButton!
    
    
    lazy var imageViews: [UIImageView] = [
        imageView, imageView2, imageView3, imageView4, imageView5,
        imageView6, imageView7, imageView8, imageView9, imageView10,
        imageView11, imageView12, imageView13, imageView14, imageView15,
        imageView16, imageView17, imageView18, imageView19, imageView20
    ]
    
    var emptyIndex = 0
    var originalImages: [UIImage?] = []
    var showingAnswer = false
    var currentImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, imageView) in imageViews.enumerated() {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
            imageView.isUserInteractionEnabled = true
            originalImages.append(imageView.image)
            
            imageView.backgroundColor = .clear
            
            if index == emptyIndex {
                imageView.image = nil
                imageView.backgroundColor = .black
            }
        }
        
        shufflePuzzle()
        
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        if let tappedIndex = imageViews.firstIndex(of: tappedImageView), !showingAnswer {
            if isAdjacent(tappedIndex, to: emptyIndex) {
                swapImages(at: tappedIndex, with: emptyIndex)
                checkIfSolved()
            }
        }
    }
    
    func swapImages(at firstIndex: Int, with secondIndex: Int) {
            let tempImage = self.imageViews[firstIndex].image
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageViews[firstIndex].image =
                    self.imageViews[secondIndex].image
                    self.imageViews[secondIndex].image = tempImage
                    
                }) { _ in
                  
                    self.imageViews.forEach { $0.backgroundColor = .clear }
                    self.imageViews[self.emptyIndex].backgroundColor = .black
                }
                
                emptyIndex = firstIndex
    }
    
    func isAdjacent(_ firstIndex: Int, to secondIndex: Int) -> Bool {
        let difference = abs(firstIndex - secondIndex)
        return difference == 1 || difference == 5
    }
    
    
    @IBAction func shuffleTap(_ sender: UIButton) {
        shufflePuzzle()
    }
    
    
    
    func shufflePuzzle() {
        let shuffledImages = originalImages.shuffled()
          if let newEmptyIndex = shuffledImages.firstIndex(where: { $0 == nil }) {
              emptyIndex = newEmptyIndex
          }
          for i in 0..<imageViews.count {
              imageViews[i].image = shuffledImages[i]
          }
          
          imageViews.forEach { $0.backgroundColor = .clear }
          
          imageViews[emptyIndex].backgroundColor = .black
          
          shuffleButton.setTitle("Shuffle", for: .normal)
          shuffleButton.backgroundColor = UIColor.systemBlue
          
          imageViews.forEach { $0.isUserInteractionEnabled = true }
          showingAnswer = false
          answerButton.setTitle("Show Answer", for: .normal)
    }
    
    
    
    
    @IBAction func answerTap(_ sender: UIButton) {
        toggleAnswer()
    }
    
    func toggleAnswer() {
        
        showingAnswer.toggle()
        
          if showingAnswer {
             
              currentImages = imageViews.map { $0.image }
              
              for (index, imageView) in imageViews.enumerated() {
                  imageView.image = originalImages[index]
            
              }
              answerButton.setTitle("Hide Answer", for: .normal)
              
              imageViews.forEach { $0.isUserInteractionEnabled = false }
          } else {
              
              for (index, imageView) in imageViews.enumerated() {
                  imageView.image = currentImages[index]
              }
              answerButton.setTitle("Show Answer", for: .normal)
              
              imageViews.forEach { $0.isUserInteractionEnabled = true }
            
              imageViews.forEach { $0.backgroundColor = .clear }
              
              imageViews[emptyIndex].backgroundColor = .black
          }
    }
    
    func getAdjacentIndexes(to index: Int) -> [Int] {
        let row = index / 5
        let col = index % 5
        var indexes = [Int]()
        
        if col > 0 { indexes.append(index - 1) }
        if col < 4 { indexes.append(index + 1) }
        if row > 0 { indexes.append(index - 5) }
        if row < 3 { indexes.append(index + 5) }
        
        return indexes.filter { $0 != emptyIndex }
    }
    
    func checkIfSolved() {
        for (index, imageView) in imageViews.enumerated() {
            if index != emptyIndex && imageView.image != originalImages[index] {
                return
            }
        }
        
        shuffleButton.setTitle("Solved! Shuffle Again?", for: .normal)
        shuffleButton.backgroundColor = UIColor.green
        showAlert(title: "Congratulations!", message: "You've solved the puzzle!")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }
}
