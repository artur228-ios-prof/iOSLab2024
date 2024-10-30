//
//  PostTableViewCell.swift
//  HW_2a
//
//  Created by Артур Мавликаев on 29.10.2024.
//

import UIKit

class PostTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let identifier = "PostTableViewCell"
    private var images: [UIImage] = []
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        imagesCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(customTextLabel)
        contentView.addSubview(imagesCollectionView)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            customTextLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            customTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            customTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            imagesCollectionView.topAnchor.constraint(equalTo: customTextLabel.bottomAnchor, constant: 10),
            imagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 100), // Высота коллекции
            imagesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with post: Post) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateLabel.text = dateFormatter.string(from: post.date)
        customTextLabel.text = post.text
        images = Array(post.images.prefix(2))
        imagesCollectionView.reloadData()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
extension PostTableViewCell:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100) 
    }
}
