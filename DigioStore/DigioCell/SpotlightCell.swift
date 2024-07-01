//
//  SpotlightCell.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 28/06/24.
//

import UIKit

class SpotlightCell: UICollectionViewCell {
    static let reuseIdentifier = "SpotlightCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Imagem não carregada"
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: URL) {
        imageView.isHidden = false
        errorLabel.isHidden = true
        
        loadImage(from: url)
    }
    
    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load image: \(error)")
                DispatchQueue.main.async {
                    self.imageView.isHidden = true
                    self.errorLabel.isHidden = false
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.imageView.isHidden = true
                    self.errorLabel.isHidden = false
                }
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                self.imageView.isHidden = false
                self.errorLabel.isHidden = true
            }
        }
        task.resume()
    }
    
}
