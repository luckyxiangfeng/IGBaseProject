//
//  IGQuoteViewController.m
//  Iguama
//
//  Created by Kennith.Zeng on 2017/3/1.
//  Copyright © 2017年 Kennith.Zeng. All rights reserved.
//

#import "IGQuoteViewController.h"
#import "JiaSearchBar.h"
@interface IGQuoteViewController ()<JiaSearchBarDelegate,UISearchBarDelegate,UIWebViewDelegate>
@property (nonatomic, strong)JiaSearchBar *searchBar;
@property (nonatomic, strong) UIWebView* myWebView;
@property (nonatomic, strong) NSString *goWebUrl;
@property(nonatomic, strong) NSMutableURLRequest* request;
@property(strong, nonatomic) UIActivityIndicatorView* activityIndicator;
@end

@implementation IGQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSearchBar];
    [self creatWebView];
    // Do any additional setup after loading the view.
}


- (void)creatSearchBar
{
    if (!_searchBar) {
        _searchBar = [[JiaSearchBar alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH-8, 44)];
        _searchBar.delegate=self;
        _searchBar.placeholder = @"Enter a store URL";
        _searchBar.placeholderColor = HEXCOLOR(0x333333);
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.iconAlign = JiaSearchBarIconAlignCenter;
        _searchBar.keyboardType=UIKeyboardTypeURL;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.textFieldBackgroundColor = RGB(242, 242, 242);
        _searchBar.textBorderColor = [UIColor clearColor];
        _searchBar.returnKeyType = UIReturnKeyGo;
        [_searchBar.cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
        [self.navigationController.view addSubview:_searchBar];
        [_searchBar showKeybordResponder];
  
    }
    
}

- (void)creatWebView{

    if (!_myWebView) {
        _myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _myWebView.delegate = self;
        _myWebView.backgroundColor = PAGE_BACKGROUND_COLOR;
        //添加下拉刷新控件
        @weakify(self)
        _myWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.myWebView reload];
        }];
        [self.view addSubview:_myWebView];
        
        _activityIndicator = [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = YES;
        [_activityIndicator setCenter:CGPointMake(CGRectGetWidth(_myWebView.frame)/2, CGRectGetHeight(_myWebView.frame)/2)];
        [_myWebView addSubview:_activityIndicator];
        
    }

}

- (void)loadWebViewUrl:(NSString *)urlStr{
    NSURL* url = [NSURL URLWithString:urlStr];
    _request = [NSMutableURLRequest requestWithURL:url
                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                   timeoutInterval:15];
    [self.myWebView loadRequest:_request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --JiaSearchBar delegate

-(void)searchBarSearchButtonClicked:(JiaSearchBar *)searchBar
{
    
    NSString *searchText = searchBar.text;
    [self loadWebViewUrl:searchText];

}
- (void)searchBar:(JiaSearchBar *)searchBar textDidChange:(NSString *)searchText{

}

- (void)searchBarCancelButtonClicked:(JiaSearchBar *)searchBar
{

}

#pragma mark - webViewDelegate

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [self.myWebView.scrollView.mj_header endRefreshing];
    NSLog(@"加载完成");
    [_activityIndicator stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *newURL=[[request URL] absoluteString];
    if([newURL hasPrefix:@"finish://"])
    {
        NSArray *stringArray=[newURL componentsSeparatedByString:@"//"];
        if (stringArray.count<1) {
            return YES;
        }
        
        if ([[stringArray objectAtIndex:1] isEqualToString:@"order"]||[[stringArray objectAtIndex:1] isEqualToString:@"error"]||[[stringArray objectAtIndex:1] isEqualToString:@"back"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView*)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_activityIndicator startAnimating];
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    if ([error code] == NSURLErrorCancelled)
        return;
    else
        NSLog(@"%@", error.localizedDescription);
    [_activityIndicator stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) response;
        if ((([httpResponse statusCode]/100) == 2)) {
            NSLog(@"connection ok");
        }
        else {
            NSError* error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:nil];
            if ([error code] == 404) {
                [self.myWebView.scrollView.mj_header endRefreshing];
                NSLog(@"没有访问到URL");
            }
        }
    }
}




#pragma mark - 自定义导航栏
-(NSMutableAttributedString*)setTitle
{
    NSString *titleStr=@"Quote";
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x333333) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:kFontESize(18) range:NSMakeRange(0, title.length)];
    
    return title;
}
//不显示左按钮
- (UIButton *)set_leftButton
{
    return nil;
}


@end
