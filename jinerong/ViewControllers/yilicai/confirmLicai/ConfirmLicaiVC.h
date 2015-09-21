//
//  ConfirmLicaiVC.h
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"
#import "ConfirmLCCell.h"
@interface ConfirmLicaiVC : JERViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,retain)ConfirmLCCell *confirmcell;
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)UIView *shieldView;
@property(nonatomic,retain)NSString *projNo;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSMutableArray *m_aryRedpackets;
@property(nonatomic,retain)NSString *packetType;
@property(nonatomic,retain)NSString *packetAmt;
@property(nonatomic,retain)NSString *bidMoney;
@property(nonatomic,assign)NSInteger selectedPacketIndex;
@property(nonatomic,retain)NSDictionary *m_detailData;
@property(nonatomic,retain)NSString *nickName;

-(void)updateData;
-(void)bidTheItem:(NSString*)bidAmount redPacket:(NSString*)redpacket;
-(void)creatPickerView;
@end
