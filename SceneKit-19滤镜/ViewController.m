//
//  ViewController.m
//  SceneKit-19滤镜
//
//  Created by ShiWen on 2017/7/28.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property (nonatomic,strong)SCNView *mScnView;
@property (weak, nonatomic) IBOutlet UIView *preview;
@property (nonatomic,strong) SCNNode *boxNode;
@property (nonatomic,strong) CIFilter* preViewOne,*preViewTwo,*preViewThree;
@property (nonatomic,strong) NSMutableArray *muArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
    self.muArray = [[NSMutableArray alloc] init];
    
    SCNNode *cameraNdoe = [SCNNode node];
    cameraNdoe.camera = [SCNCamera camera];
    cameraNdoe.position = SCNVector3Make(0, 0, 30);
    [self.mScnView.scene.rootNode addChildNode:cameraNdoe];
    
    self.boxNode = [SCNNode nodeWithGeometry:[SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0]];
    self.boxNode.geometry.firstMaterial.diffuse.contents = @"box2.jpg";
    [self.mScnView.scene.rootNode addChildNode:self.boxNode];
    
}
#warning 更多效果，详见官方文档
//效果一
-(CIFilter *)preViewOne{
    if (!_preViewOne) {
        _preViewOne = [CIFilter filterWithName:@"CIComicEffect"];
    }
    return _preViewOne;
}

//效果二
-(CIFilter *)preViewTwo{
    if (!_preViewTwo) {
        _preViewTwo = [CIFilter filterWithName:@"CICrystallize"];
    }
    return _preViewTwo;
}
//效果三
-(CIFilter *)preViewThree{
    if (!_preViewThree) {
        _preViewThree = [CIFilter filterWithName:@"CICircularScreen"];
    }
    return _preViewThree;
}

- (IBAction)selectAction:(UISwitch *)sender {
    NSInteger tag = sender.tag;
    BOOL isOn = sender.isOn;
    
    switch (tag) {
        case 0:
            NSLog(@"效果一");
            if (isOn) {
                [self.muArray addObject:self.preViewOne];
            }else{
                [self.muArray removeObject:self.preViewOne];
            }
            break;
        case 1:
            if (isOn) {
                [self.muArray addObject:self.preViewTwo];
            }else{
                [self.muArray removeObject:self.preViewTwo];
            }
            NSLog(@"效果二");
            break;
        case 2:
            if (isOn) {
                [self.muArray addObject:self.preViewThree];
            }else{
                [self.muArray removeObject:self.preViewThree];
            }
            NSLog(@"效果三");
            break;
            
        default:
            break;
    }
    self.boxNode.filters = self.muArray;
}

-(SCNView *)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.allowsCameraControl = YES;
        _mScnView.scene = [SCNScene scene];
        _mScnView.backgroundColor = [UIColor blackColor];
        [_mScnView addSubview:self.preview];
    }
    return _mScnView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
