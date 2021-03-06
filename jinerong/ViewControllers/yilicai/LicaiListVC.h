//
//  LicaiListVC.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"
#import "JiekuanCell2.h"
@interface LicaiListVC : JERViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)UIView *shieldView;
@property(nonatomic,retain)NSMutableArray *m_aryMonths;
@property(nonatomic,assign)NSInteger selectedMonth;
@property(nonatomic,retain)NSMutableArray *m_showedDatas;
@property(nonatomic,retain)NSMutableArray *m_aryDatas;
@property(nonatomic,retain)NSMutableDictionary *m_dicInput;
@property(nonatomic,assign)NSInteger indexFlag;//0:licai 1:borrow
@property(nonatomic,retain)IBOutlet UILabel *label_lc;
@property(nonatomic,retain)IBOutlet UILabel *label_jk;
@property(nonatomic,retain)IBOutlet UIView *lineView_l;
@property(nonatomic,retain)IBOutlet UIView *lineView_r;
//bid product
@property(nonatomic,retain)NSMutableDictionary *m_dicTypes;//bid product types;
//borrow
@property(nonatomic,assign)NSInteger borrowType;//0:信用贷1:抵押贷2:担保贷
@property(nonatomic,retain)NSDictionary *borrowPreData;
@property(nonatomic,assign)float borrowAmtMin;
@property(nonatomic,assign)float borrowAmtMax;
@property(nonatomic,retain)JiekuanCell2 *m_jiekuancell2;
-(void)updateData;
-(void)showLicaiDetailVC:(NSString*)projNo;
-(void)bidLicai:(NSString*)projNo;
-(void)jiekuanTypeChange:(NSInteger)index;
-(void)showJiekuanCondition;
-(void)appleBorrow:(NSDictionary*)applyData;
-(void)creatPickerView;
@end
