//
//  aboutUsCell2.m
//  jinerong
//
//  Created by zhaoml on 15/8/20.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//

#import "aboutUsCell2.h"

@implementation aboutUsCell2

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.labelContent.text= @"      上海信津金融信息服务有限公司，现已成为以上海、天津、北京三大直辖市为中心，立足华北、华东地区，辐射全国的集团性金融服务公司——信津集团。公司在5年的时间里，为中小企业提供融资服务数额达二十亿元，在推动中小企业发展和区域经济发展方面做出了重要贡献。公司与中国银行、中国工商银行、中国农业银行、中国民生银行、上海银行、浦发银行、天津银行、天津渤海银行等十多家银行展开长期合作，实现互联网金融和传统金融机构的互补共赢。\n      金E融，隶属于信津集团旗下，集理财、众筹、私募股权基金业务于一体的互联网金融信息咨询与服务平台。平台适应于当前中国金融市场的整体发展趋势和需求。以线上运营、线下审核为模式，以互联网金融服务和优化用户体验为核心，以“普惠金融”为企业发展的根本价值，为资质良好，具备发展潜力的中小微型企业和个人提供相应的融资服务，并以安全、低门槛、高效率为前提，为投资客户提供相应的金融投资咨询与服务。\n      金E融平台正是以信津集团的成熟管理、服务和运营经验为基础，构建起一支由产品服务、风控管理和业务项目等部门于一体的团队人员体系，部门之间默契合作，团队人员各司其职，从而实现工作价值的最大化，为投融资客户实现最有价值的服务，成为其最满意的合作伙伴。\n      金E融平台现涉及包含投资理财、众筹项目和私募股权基金三大产品业务模块，针对个人投资理财、中小微型企业融资、个人产品研发众筹、众筹项目投资和私募股权融资等需求，提供相应的投融资、信息咨询、风险控制、投资建议等相关内容的服务。  ";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
