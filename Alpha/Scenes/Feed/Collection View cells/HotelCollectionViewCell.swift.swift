//
//  HotelsCollectionViewCell.swift
//  Alpha
//
//  Created by Theo Mendes on 18/10/19.
//  Copyright © 2019 Hurb. All rights reserved.
//

import UIKit
import Kingfisher

class HotelCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties

    var hotel: Deal? {
        didSet {
            guard let hotel = hotel else { return }
            titleLabel.text = hotel.name
            priceLabel.text = "\(hotel.price.symbol) \(hotel.price.amount)"
            descriptionLabel.text = "\(hotel.address.city) | \(hotel.address.state)"
            var amenitiesText: String = "\(L10n.Feed.Cell.amenities): "

            for (idx, element) in hotel.amenities.enumerated() {
                if idx > 2 {
                    break
                }
                if idx == hotel.amenities.startIndex {
                    amenitiesText = amenitiesText + " \(element.name)"
                } else if idx != hotel.amenities.endIndex-1 {
                    amenitiesText = amenitiesText + ", \(element.name)"
                }
            }

            amenitiesLabel.text = amenitiesText

            guard let imageURL = hotel.image else { return }
            guard var comps = URLComponents(url: imageURL,
                                            resolvingAgainstBaseURL: false) else { return }
            comps.scheme = "https"
            imageView.kf.setImage(with: comps.url)

            if hotel.price.discount < 0 {
                discountLabel.text = "\(hotel.price.discount)%"
                discountLabel.isHidden = false
            }
        }
    }

    var imageView: GradientUIImage = {
        let view = GradientUIImage(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        view.backgroundColor = .gray
        view.clipsToBounds = true
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    let amenitiesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = Theme.hurbDarkGray
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = Theme.hurbGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    let priceLabel: PaddingUILabel = {
        let label = PaddingUILabel(withInsets: 8, 8, 10, 10)
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.cornerRadius = 14
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        label.backgroundColor = Theme.hurbYellow
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()

    let discountLabel: PaddingUILabel = {
        let label = PaddingUILabel(withInsets: 8, 8, 10, 10)
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.isHidden = true
        label.layer.cornerRadius = 14
        label.layer.maskedCorners = [.layerMinXMaxYCorner]
        label.backgroundColor = Theme.hurbOrange
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()

    // MARK: - View methods

    override func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(discountLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(amenitiesLabel)
    }

    override func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200).priority(999)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(imageView.snp.bottom).offset(-5)
            make.leading.equalTo(imageView.snp.leading).offset(10)
            make.trailing.equalTo(imageView.snp.trailing).offset(-10)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top)
            make.trailing.equalTo(imageView.snp.trailing)
        }

        discountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.trailing.equalTo(imageView.snp.trailing)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.leading).offset(10)
            make.trailing.equalTo(imageView.snp.trailing).offset(-10)
        }

        amenitiesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.leading).offset(10)
            make.trailing.equalTo(imageView.snp.trailing).offset(-10)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        hotel = nil

        // reset (hide) the checkmark label
        discountLabel.isHidden = true
        titleLabel.text = nil
        priceLabel.text = nil
        descriptionLabel.text = nil
        imageView.image = nil
        discountLabel.text = nil

    }
}
