//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by 朱正晶 on 15-3-25.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "BNRWebViewController.h"

@interface BNRWebViewController() <UIWebViewDelegate>
@property (nonatomic, strong) UIToolbar *histroyToolBar;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIBarButtonItem *goBackBarItem;
@property (nonatomic, strong) UIBarButtonItem *goHeadBarItem;
@end


@implementation BNRWebViewController

- (void)loadView
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    self.view = self.webView;
    _histroyToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, rect.size.height - 50, rect.size.width, 50)];
    _histroyToolBar.tintColor = [UIColor blackColor];
    [self.view addSubview:self.histroyToolBar];
    self.goBackBarItem = [[UIBarButtonItem alloc]
                          initWithTitle:@"Back"
                          style:UIBarButtonItemStylePlain
                          target:self action:@selector(webViewGoBack)];
    self.goHeadBarItem = [[UIBarButtonItem alloc]
                          initWithTitle:@"Head"
                          style:UIBarButtonItemStylePlain
                          target:self action:@selector(webViewGoHead)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:self
                                      action:nil];
    self.histroyToolBar.items = @[self.goBackBarItem, flexibleSpace, self.goHeadBarItem];
    
    [self updateBarItem];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self updateBarItem];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self updateBarItem];
}

- (void)updateBarItem
{
    self.goBackBarItem.enabled = self.webView.canGoBack;
    self.goHeadBarItem.enabled = self.webView.canGoForward;
}

- (void)webViewGoBack
{
    [self.webView goBack];
}

- (void)webViewGoHead
{
    [self.webView goForward];
}


- (void)setUrl:(NSURL *)url
{
    _url = url;
    if (_url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_url];
        [(UIWebView *)self.view loadRequest:req];
    }
}

@end
