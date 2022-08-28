//
//  MovieContentsStackView.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/28.
//

import UIKit
import SnapKit

final class MovieContentsStackView: UIStackView {
    private let title: String
    private let contents: String
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.text = title
    }
    
    private lazy var contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.text = contents
    }
    
    init(title: String, contents: String) {
        self.title = title
        self.contents = contents
        
        super.init(frame: .zero)
        
        axis = .horizontal
        
        [titleLabel, contentsLabel]
            .forEach {
                addArrangedSubview($0)
            }
        
        titleLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(80)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

