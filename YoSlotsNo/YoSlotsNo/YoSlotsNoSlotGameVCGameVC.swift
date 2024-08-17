//
//  ThirdGame.swift
//  JackpotSlotJubilee
//
//  Created by FJ on 09/08/24.
//

import UIKit

import UIKit

class YoSlotsNoSlotGameVCGameVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return .landscape
        }
    let gridSize = 12 // Number of cells in a row or column
    var cellImages: [UIImage] = []
    var treasureIndex: Int = 0
    var currentScore: Int = 100
    var isGameActive: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupGame()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = collectionView.frame.size.width / CGFloat(gridSize / 2) // Square cells
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    private func setupGame() {
        // Load images for cells
        let placeholderImage = UIImage(named: "decoy")!
        cellImages = Array(repeating: placeholderImage, count: gridSize * gridSize)
        
        // Set one random image as the treasure
        treasureIndex = Int.random(in: 0..<cellImages.count)
        cellImages[treasureIndex] = UIImage(named: "decoy")! // Hidden treasure initially
        
        updateUI()
    }
    
    private func updateUI() {
        scoreLabel.text = "Score: \(currentScore)"
        collectionView.reloadData()
    }
    
    private func handleSelection(at indexPath: IndexPath) {
        let selectedIndex = indexPath.item
        
        if selectedIndex == treasureIndex {
            // Correct guess
            currentScore += 100
            resultLabel.text = "Congratulations! You found the treasure!"
            
            // Reveal the treasure
            cellImages[selectedIndex] = UIImage(named: "treasure")!
            
            // End the game after the selection
            isGameActive = false
            updateUI()
        } else {
            // Incorrect guess
            currentScore -= 10
            resultLabel.text = "Sorry! That's not the treasure."
            
            // Change the image of the incorrect cell
            cellImages[selectedIndex] = UIImage(named: "wrong")!
            
            // Reset the game after a wrong guess
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.resetGame()
            }
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popViewController(animated: true)
    }
    
    private func resetGame() {
        // Reset the game state
        currentScore = 100
        isGameActive = true
        setupGame() // Reinitialize the game and collection view
        resultLabel.text = ""
        collectionView.isUserInteractionEnabled = true
    }
}

extension YoSlotsNoSlotGameVCGameVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize * gridSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // Remove any existing image views
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create an image view and set its image
        let imageView = UIImageView(image: cellImages[indexPath.item])
        imageView.frame = cell.contentView.bounds
        imageView.contentMode = .scaleAspectFill
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isGameActive {
            handleSelection(at: indexPath)
        }
    }
}


struct Character {
    let name: String
    let ability: Ability
}

enum Ability {
    case fireball, multishot
}

struct Quest {
    let title: String
    let description: String
}
