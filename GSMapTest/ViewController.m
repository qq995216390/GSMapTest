

#import "ViewController.h"
#import "SystemMessageCell.h"
#import "BaseViewController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"



@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,retain)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTableView];

}

- (void)createTableView{
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"初始化地图，需要在入口类设置Key--",
                      @"官方Demo自定义标注点实现。CustomAnnotationView的select方法里面初始化CustomCalloutView，以达到点击自定义大头针显示详情的效果---A",
                      @"自定义圆点显示并标记，点击控制台输出经纬度----B",
                      @"点击更改缩放级别--模拟数据，请点击：徐汇--龙华--其他数据为空，（不包含捏合缩放）---C",
                      @"在点击操作的基础上 增加 捏合缩放更改数据源功能---------D",
                      @"地图 周边 查询，有时间会补上",

                      nil];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusAndNav_H, SCREEN_WIDTH, SCREEN_HEIGHT - statusAndNav_H)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    AdjustsScrollViewInsetNever(self, self.tableView);
    _tableView.estimatedRowHeight = 90;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"SystemMessageCell" bundle:nil] forCellReuseIdentifier:@"SystemMessageCell"];
    [self.view addSubview:_tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return -1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemMessageCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        BaseViewController *baseVC = [BaseViewController new];
        [self.navigationController pushViewController:baseVC animated:YES];
    }else if(indexPath.row==1){
        AViewController *aVC = [AViewController new];
        [self.navigationController pushViewController:aVC animated:YES];
    }else if (indexPath.row==2){
        BViewController *aVC = [BViewController new];
        [self.navigationController pushViewController:aVC animated:YES];
    }else if (indexPath.row==3){
        CViewController *aVC = [CViewController new];
        [self.navigationController pushViewController:aVC animated:YES];
    }else if (indexPath.row==4){
        DViewController *aVC = [DViewController new];
        [self.navigationController pushViewController:aVC animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.title = @"高德Demo";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


