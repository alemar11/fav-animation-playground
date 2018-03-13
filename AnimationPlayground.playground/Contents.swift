//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class HeartButton: UIButton {

    private var heartImageView: UIImageView?
    private var unselectedImage = UIImage(named: "icon-heart")
    private var selectedImage = UIImage(named: "icon-heart-filled")

    override func didMoveToWindow() {
        configure()
    }

    func configure() {
        if heartImageView != nil {
            return
        }

        let imageView = UIImageView(frame: self.bounds)
        imageView.image = isSelected ? selectedImage : unselectedImage
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        heartImageView = imageView

        self.addTarget(self, action: #selector(HeartButton.touchedIn(button:)), for: .touchDown)
        self.addTarget(self, action: #selector(HeartButton.touchedUp(button:)), for: .touchUpInside)
    }

    func configureImage() {
        heartImageView?.image = isSelected ? selectedImage : unselectedImage
    }

    @objc func touchedIn(button: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.heartImageView?.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }, completion: nil)
    }

    @objc func touchedUp(button: UIButton) {
        button.isSelected = !button.isSelected
        if isSelected {
            favoriteAnimate()
        } else {
            heartImageView?.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)

            UIView.animate(withDuration: 0.2,
                           delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                            self?.heartImageView?.transform = CGAffineTransform.identity
                }, completion: { [weak self] _ in
                    self?.heartImageView?.image = self?.unselectedImage
            })
        }
    }

    // swiftlint:disable:next function_body_length
    func favoriteAnimate() {
        guard let heartImageView = heartImageView else { return }

        let finalBounds = CGRect(x: 0, y: 0, width: 26, height: 22)
        let centerPoint = CGPoint(x: 20, y: 20)
        let masterDuration = 4.8

        let heartShape = CAShapeLayer()
        heartShape.bounds = finalBounds
        heartShape.position = centerPoint
        heartShape.fillColor = UIColor.rbRed.cgColor
        heartShape.path = drawFilledHeart().cgPath

        let circleShape = CAShapeLayer()
        circleShape.bounds = finalBounds
        circleShape.position = centerPoint
        circleShape.path = drawRing().cgPath
        circleShape.fillColor = nil
        circleShape.strokeColor = UIColor.rbApricot.cgColor
        circleShape.lineWidth = 2.0
        circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)

        let growHeartAnimation = CAKeyframeAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        growHeartAnimation.values = [CATransform3DMakeScale(0.0, 0.0, 1.0),
                                     CATransform3DMakeScale(1.2, 1.2, 1.0),
                                     CATransform3DMakeScale(1.0, 1.0, 1.0)]
        growHeartAnimation.keyTimes = [0.0,
                                       0.7,
                                       1.0]
        growHeartAnimation.duration = masterDuration/4
        growHeartAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
                                              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        ]

        let growCircleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        growCircleAnimation.fromValue = CATransform3DMakeScale(0.0, 0.0, 1.0)
        growCircleAnimation.toValue = CATransform3DMakeScale(2.0, 2.0, 1.0)
        growCircleAnimation.duration = masterDuration/2
        growCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        let fadeCircleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.opacity))
        fadeCircleAnimation.fromValue = 1.0
        fadeCircleAnimation.toValue = 0.0
        fadeCircleAnimation.beginTime = growCircleAnimation.duration/2 + growCircleAnimation.beginTime
        fadeCircleAnimation.duration = growCircleAnimation.duration/2
        fadeCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        let circleGroupAnimation = CAAnimationGroup()
        circleGroupAnimation.duration = growCircleAnimation.duration
        circleGroupAnimation.animations = [growCircleAnimation, fadeCircleAnimation]

        let beginTime = layer.convertTime(CACurrentMediaTime() + masterDuration/8, from: layer)
        let explosionLayer = createExplosion(beginTime: beginTime)
        explosionLayer.emitterPosition = centerPoint

        heartImageView.transform = CGAffineTransform.identity

        UIViewPropertyAnimator
            .runningPropertyAnimator(withDuration: masterDuration * 0.2,
                                     delay: 0.0,
                                     options: .curveEaseOut,
                                     animations: {
                                        heartImageView.transform = CGAffineTransform.identity
                                        heartImageView.alpha = 0.0
            },
                                     completion: nil)
        layer.insertSublayer(heartShape, above: heartImageView.layer)
        layer.insertSublayer(circleShape, below: heartImageView.layer)

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.heartImageView?.alpha = 1.0
            strongSelf.heartImageView?.image = strongSelf.selectedImage
            circleShape.removeFromSuperlayer()
            heartShape.removeFromSuperlayer()
        }
        heartShape.add(growHeartAnimation, forKey: "growHeart")
        circleShape.add(circleGroupAnimation, forKey: "Circle")
        layer.insertSublayer(explosionLayer, below: heartImageView.layer)
        CATransaction.commit()
    }
}

extension HeartButton {
    func drawFilledHeart(frame: CGRect = CGRect(x: 0, y: 0, width: 26, height: 22)) -> UIBezierPath {

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 15.15, y: 2.19))
        bezierPath.addLine(to: CGPoint(x: 13.25, y: 4.11))
        bezierPath.addLine(to: CGPoint(x: 11.35, y: 2.19))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 0.25), controlPoint1: CGPoint(x: 10.17, y: 0.99), controlPoint2: CGPoint(x: 8.55, y: 0.25))
        bezierPath.addCurve(to: CGPoint(x: 0.25, y: 6.86), controlPoint1: CGPoint(x: 3.16, y: 0.25), controlPoint2: CGPoint(x: 0.25, y: 3.21))
        bezierPath.addCurve(to: CGPoint(x: 2.59, y: 11.59), controlPoint1: CGPoint(x: 0.25, y: 8.69), controlPoint2: CGPoint(x: 0.89, y: 9.86))
        bezierPath.addLine(to: CGPoint(x: 12.1, y: 21.27))
        bezierPath.addCurve(to: CGPoint(x: 13.25, y: 21.75), controlPoint1: CGPoint(x: 12.42, y: 21.59), controlPoint2: CGPoint(x: 12.83, y: 21.75))
        bezierPath.addCurve(to: CGPoint(x: 14.4, y: 21.27), controlPoint1: CGPoint(x: 13.67, y: 21.75), controlPoint2: CGPoint(x: 14.08, y: 21.59))
        bezierPath.addLine(to: CGPoint(x: 23.89, y: 11.61))
        bezierPath.addCurve(to: CGPoint(x: 26.25, y: 6.86), controlPoint1: CGPoint(x: 25.57, y: 9.91), controlPoint2: CGPoint(x: 26.25, y: 8.69))
        bezierPath.addCurve(to: CGPoint(x: 19.75, y: 0.25), controlPoint1: CGPoint(x: 26.25, y: 3.21), controlPoint2: CGPoint(x: 23.34, y: 0.25))
        bezierPath.addCurve(to: CGPoint(x: 15.15, y: 2.19), controlPoint1: CGPoint(x: 17.95, y: 0.25), controlPoint2: CGPoint(x: 16.33, y: 0.99))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true

        return bezierPath
    }

    func drawRing() -> UIBezierPath {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 1, y: -1, width: 24, height: 24))
        return ovalPath
    }

    func createExplosion(beginTime: CFTimeInterval) -> CAEmitterLayer {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterZPosition = 10.0
        emitterLayer.emitterSize = CGSize(width: 1.0, height: 1.0)
        emitterLayer.emitterShape = kCAEmitterLayerCircle

        let cellRed = emitterCell(color: .rbRed, beginTime: beginTime)
        let cellBlue = emitterCell(color: .rbBlue, beginTime: beginTime)
        let cellGreen = emitterCell(color: .rbGreen, beginTime: beginTime)
        let cellOrange = emitterCell(color: .rbApricot, beginTime: beginTime)
        emitterLayer.emitterCells = [cellRed, cellBlue, cellGreen, cellOrange]
        return emitterLayer
    }

    func emitterCell(color: UIColor, beginTime: CFTimeInterval) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.scale = 0.1
        cell.scaleRange = 0.1
        cell.duration = 0.3
        cell.emissionRange = CGFloat(Double.pi) * 2
        cell.lifetime = 0.5
        cell.alphaSpeed = -3
        cell.birthRate = 10.0
        cell.velocity = 170.0
        cell.velocityRange = 50.0
        cell.yAcceleration = 5.0
        cell.scaleSpeed = -0.2
        cell.beginTime = beginTime
        cell.contents = UIImage(named: "Ball_blue")!.filledImage(with: color).cgImage
        return cell
    }
}

public extension UIImage {
    func filledImage(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)

        let context = UIGraphicsGetCurrentContext()!
        color.setFill()

        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        context.setBlendMode(CGBlendMode.colorBurn)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.draw(self.cgImage!, in: rect)

        context.setBlendMode(CGBlendMode.sourceIn)
        context.addRect(rect)
        context.drawPath(using: CGPathDrawingMode.fill)

        let coloredImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return coloredImg
    }
}


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let button = HeartButton(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
        button.configure()

        view.addSubview(button)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()





