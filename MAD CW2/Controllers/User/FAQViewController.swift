//
//  FAQViewController.swift
//  Stadia
//
//  Created by user239258 on 8/26/23.
//

import UIKit

//
//  FAQViewController.swift
//  Stadia
//
//  Created by user239258 on 8/26/23.
//

import UIKit

class FAQViewController: UIPageViewController {
    
    var viewControllersList = [UIViewController]()
    var currentPageIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        let storyboard = UIStoryboard(name: "FAQs", bundle: nil)
        
        viewControllersList.append(storyboard.instantiateViewController(withIdentifier:"rateMovieFAQViewController"))
        viewControllersList.append(storyboard.instantiateViewController(withIdentifier:"favouriteMovieFAQViewController"))
        
        if let firstViewController = viewControllersList.first {
            setViewControllers([firstViewController],direction: .forward, animated: true, completion: nil)
        }
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.blue
    }
}

extension FAQViewController : UIPageViewControllerDelegate{
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllersList.count
    }
    
}

extension FAQViewController : UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllersList.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        
        return viewControllersList[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllersList.firstIndex(of: viewController), index + 1 < viewControllersList.count else {
            return nil
        }
        
        return viewControllersList[index + 1]
    }
}

