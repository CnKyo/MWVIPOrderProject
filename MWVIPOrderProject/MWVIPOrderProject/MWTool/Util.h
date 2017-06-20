//
//  Util.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWHeader.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface Util : NSObject
+ (BOOL)isPureInt:(NSString*)string;
    
+ (BOOL)isPureFloat:(NSString*)string;
    
+(BOOL)checkNum:(NSString *)numStr;                         //验证为数字
    
+(BOOL)checkSFZ:(NSString *)numStr;                         //验证身份证
    
    
+(UIImage*)scaleImg:(UIImage*)org maxsizeW:(CGFloat)maxW; //缩放图片,,最大多少
    
    
+(UIImage*)scaleImg:(UIImage*)org maxsize:(CGFloat)maxsize; //缩放图片
    /**
     *  时间戳转date
     *
     *  @param second 时间戳
     *
     *  @return 返回date
     */
+(NSDate*)dateWithInt:(double)second;
    
+(NSString*)getTimeStringPointSecond:(double)second;//2015.06.18. 12:12:00
    
+(NSString*)getTimeStringHourSecond:(double)second;
    /**
     *  时间戳转时间字符串
     *
     *  @param time 时间戳
     *
     *  @return 返回date
     */
+(NSString*)getTimeStringWithP:(double)time;//获取时间 2015.04.15
    
+(NSString*)getTimeString:(NSDate*)dat bfull:(BOOL)bfull;   //date转字符串
    /**
     *  date转字符串 2015.03.23 08:00:00
     *
     *  @param dat <#dat description#>
     *
     *  @return <#return value description#>
     */
+(NSString*)getTimeStringPoint:(NSDate*)dat;   //
    
+(NSString*)getTimeStringHour:(NSDate*)dat;   //date转字符串 2015-03-23 08:00
    
+(NSString*)getTimeStringNoYear:(NSDate*)dat;   //date转字符串 03月23日 08:00
    
    
+(NSString*)getTimeStringS:(NSDate*)dat;   //date转字符串 2015年03月23日 08:00
    
+(NSString*)getTimeStringSS:(NSDate*)dat;   //date转字符串 20150415
#pragma mark----获取当前时间
    /**
     *  获取当前时间
     *
     *  @return 返回字符串
     */
+ (NSString *)getNowTime;
    
+ (NSString *)currentTime;
#pragma mark----*  比较2个时间的大小
    /**
     *  比较2个时间的大小
     *
     *  @param date01 时间1
     *  @param date02 时间2
     *
     *  @return 返回int
     */
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02;
    
    //自动扩展,基于最后一个view的位置+高度+dif
+(void)autoExtendH:(UIView*)tagview dif:(CGFloat)dif;
    
    
    //自动扩展,基于subview的位置+高度+dif
+(void)autoExtendH:(UIView*)tagview blow:(UIView*)subview dif:(CGFloat)dif;
    
    
+(NSString *)dateForint:(double)time bfull:(BOOL)bfull;       //时间戳转字符串
    /**
     *  时间戳转字符串
     *
     *  @param time 时间戳
     *
     *  @return 返回的字符串
     */
+ (NSString *)DateTimeInt:(int)time;
    
+(NSString *) FormartTime:(NSDate*) compareDate;            //格式化时间
    /**
     *  检验手机号
     *
     *  @param mobileNum <#mobileNum description#>
     *
     *  @return <#return value description#>
     */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;               //检测是否是手机号
    
    /**
     *  检验手机号（座机）
     *
     *  @param mobileNum 电话号码
     *
     *  @return 返回bool
     */
+ (BOOL)verifyMobile:(NSString *)mobileNum;
    
    /**
     *  检验身份证
     *
     *  @param cardNo <#mVerify description#>
     *
     *  @return <#return value description#>
     */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;
    /**
     *  检验银行卡号
     *
     *  @param bankCard <#cardNo description#>
     *
     *  @return <#return value description#>
     */
+ (BOOL)checkBankCard:(NSString*)bankCard;
    
    
+(BOOL)checkPasswdPre:(NSString *)passwd;                    //检测密码合法性
    
+ (NSString *)md5:(NSString *)str;
    
+ (NSString *)md5_16:(NSString *)str;
    
    
+ (NSString *)md5_16Max:(NSString *)str;
    
    
+(void)md5_16_b:(NSString*)str outbuffer:(char*)outbuffer;
    
    
+ (NSString *)getMd5_32Bit:(NSString *)str;
    
    //把nsnull字段干掉
+(NSDictionary*)delNUll:(NSDictionary*)dic;
    
    //把nsnull字段干掉
+(NSArray*)delNullInArr:(NSArray*)arr;
    
    //#87fd74 ==> UIColor
+(UIColor*)stringToColor:(NSString*)str;
    
    //距离描述   dist:米
+(NSString*)getDistStr:(int)dist;
    
    //生成微信签名
+ (NSString *)genWxSign:(NSDictionary *)signParams parentkey:(NSString*)parentkey;
    
+ (NSString *)genWXClientSign:(NSDictionary *)signParams;
    
    
+ (NSString *)sha1:(NSString *)input;
    
    //+ (NSString *)getIPAddress:(BOOL)preferIPv4;
    
    //+ (NSDictionary *)getIPAddresses;
    
    //requrl http://api.fun.com/getxxxx
    //
+(NSString*)makeURL:(NSString*)requrl param:(NSDictionary*)param;
    
    //生成XML
+(NSString*)makeXML:(NSDictionary*)param;
    
    
+(int)gettopestV:(int)v;
    
+(NSString*)URLEnCode:(NSString*)str;
    
+(NSString*)URLDeCode:(NSString*)str;
    
    
    //20150416 => 4月16日
+(NSString*)convdatestr:(NSString*)str;
    
    
    
    ///2个时间平接
+ (NSString *)startTimeStr:(NSString *)startTime andEndTime:(NSString *)endTime;
    ///时间转换20150703->明天 或者尽头
+ (NSString *)startTimeStr:(NSString *)startSS;
    
#pragma mark----根据文字计算高度
    /**
     *  根据文字计算高度
     *
     *  @param s     要进行计算的文字
     *  @param fsize 字体大小
     *  @param width view的宽度
     *
     *  @return 返回高度
     */
+ (CGFloat)labelText:(NSString *)s fontSize:(CGFloat)fsize labelWidth:(CGFloat)width;
#pragma mark----根据文字计算宽度
    /**
     *  根据文字计算宽度
     *
     *  @param str 要进行计算的文字
     *
     *  @return 返回宽度
     */
+ (CGFloat)labelTextWithWidth:(NSString *)str;
    
    /**
     *返回值是该字符串所占的大小(width, height)
     *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
     *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
     */
+ (CGSize)boundingRectWithSize:(CGSize)size andStr:(NSString *)str;
    
#pragma mark----2015-09-01 14:30－16:30转 9月1日 14:30-16:30
+ (NSString *)mFirstStr:(NSString *)mFirstStr andSecondStr:(NSString *)secondStr;
#pragma mark----时间转时间戳（utc时间戳） 2015-09-01 14:30 转14478212545
+ (int)mTimeToInt:(NSDate *)dateStr;
#pragma maek----时间戳转换成分钟或者小时
+ (NSString *)mDuration:(int)Duration;
    
#pragma mark----label添加下划线
    ///label添加下划线
+(NSMutableAttributedString *)labelWithUnderline:(NSString *)mString;
    
#pragma mark----配送时间
+ (NSString *)mStartTimeArr:(NSArray *)Sarr andmEndTimeArr:(NSArray *)Earr;
    
+ (UIImage *)imageFromView: (UIView *) theView;
    
    ///时间date转时间戳
+ (int)DateToInt:(NSString *)date;
    
#pragma mark----2个时间比较大小
    ///2个时间比较大小
+ (NSDate *)CompareTime:(NSString *)mTimeStr;
    /**
     *  获取app名称
     *
     *  @return 返回字符串
     */
+ (NSString *)getAPPName;
    
+ (NSString *)getAppSchemes;
    /**
     *  获取app版本
     *
     *  @return 返回字符串
     */
+(NSString*)getAppVersion;
    
    
    /**
     *  获取设备型号
     *
     *  @return 返回字符串
     */
+ (NSString *)getDeviceModel;
#pragma mark----获取设备版本
    /**
     *  获取设备版本
     *
     *  @return 返回字符串
     */
+ (NSString *)getDeviceVersion;
#pragma mark----获取设备build号
    /**
     *  获取设备build号
     *
     *  @return 返回字符串
     */
+ (NSString *)getAPPBuildNum;
    /**
     *  获取设备uuid
     *
     *  @return 返回字符串
     */
+ (NSString *)getDeviceUUID;
    /*!
     * @brief 把格式化的JSON格式的字符串转换成字典
     * @param jsonString JSON格式的字符串
     * @return 返回字典
     */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
#pragma mark----字典转json字符串
    /**
     *  字典转json字符串
     *
     *  @param dic 传字典
     *
     *  @return 返回字符串
     */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
#pragma mark----数组转json字符串
    /**
     数组转json
     
     @param arr 转换的数组
     @return 返回json字符串
     */
+ (NSString *)arrToJson:(NSArray *)arr;
    
#pragma mark----过滤非法字符
+ (BOOL)isHaveIllegalChar:(NSString *)str;
#pragma mark----过滤emoji表情
    /**
     *  过滤emoji表情
     *
     *  @param string 传入字符串
     *
     *  @return 返回过滤后的字符串
     */
+ (NSString *)filterEmoji:(NSString *)string;
    
#pragma mark----RSA加密
    /**
     *  RSA加密
     *
     *  @param mText 加密内容
     *
     *  @return 返回加密内容
     */
+ (NSString *)RSAEncryptor:(NSString *)mText;
#pragma mark----富文本处理
    /**
     *  富文本处理
     *
     *  @param mContent 要处理的文本内容
     *
     *  @return 返回富文本内容
     */
+ (NSMutableAttributedString *)WKLabelWithAttributString:(NSString *)mContent andColorText:(NSString *)mColorTex;
    
    
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
    
#pragma mark----截取字符串
    /**
     截取字符串第几位
     
     @param mText  要截取的内容
     @param mLocation 从第几位开始截取
     @param mLength 要截取的长度
     
     @return 返回结果
     */
+ (NSString *)ZLCutStringWithText:(NSString *)mText andRangeWithLocation:(NSInteger)mLocation andRangeWithLength:(NSInteger)mLength;
#pragma mark----是否有优惠券
    ///是否有优惠券
+ (BOOL)iscoupon:(int)mCoupon;
    
#pragma mark---- 字符串替换
    /**
     字符串替换
     
     @param mBaseString 原字符串
     @param mWillRepStr 将要替换的字符串
     @param mToRepStr 替换为神马字符串
     @return 返回替换后的字符串
     */
+ (NSString *)ZLReplaceString:(NSString *)mBaseString andWillFromReplaceStr:(NSString *)mWillRepStr andToReplaceStr:(NSString *)mToRepStr;
    
+ (NSDictionary *)deleteEmpty:(NSDictionary *)dic;
    
+ (NSArray *)deleteEmptyArr:(NSArray *)arr;
    
#pragma mark----判断是否为url
    /**
     判断是否为url
     
     @param mString 要判断的字符串
     @return 返回bool值
     */
+ (BOOL)isUrl:(NSString *)mString;
    
#pragma mark---- 字符串过滤
    /**
     字符串过滤
     
     @param mCharaString 要过滤
     @return 返回过滤后的字符串
     */
+ (NSString *)ZLCharacterString:(NSString *)mCharaString;
    
    
#pragma mark---- 字符串判断
    /**
     判断是否包含字符串
     
     @param mString 要判断的字符串
     @return 返回yes or no
     */
+ (BOOL)ZLRangOfString:(NSString *)mString;
#pragma mark----  返回当前图片url
    /**
     返回当前图片url
     
     @param mUrl 图片的url
     @return 返回图片的URL
     */
+ (NSString *)currentSourceImgUrl:(NSString *)mUrl;
#pragma mark----字符串拼接成数组
    /**
     字符串拼接成数组
     
     @param string 要转换的字符串
     @return 返回数组
     */
+ (NSArray *)wk_StringToArr:(NSString *)string;
#pragma mark----字符串替换
    /**
     字符串替换
     
     @param oldString 原字符
     @param tagString 要替换的字符
     @return 返回字符
     */
+ (NSString *)wk_stringReplaceString:(NSString *)oldString andTag:(NSString *)tagString;
    
+ (void)ZLSaveLocalData:(id)mData withKey:(NSString *)mKey;
+ (id)ZLGetLocalDataWithKey:(NSString *)mKey;
#pragma mark----字符串截取
    /**
     字符串截取
     
     @param mIndex 下标
     @param mString 要截取的字符串
     @return 返回字符串
     */
+ (NSString *)wk_stringToSubString:(NSInteger)mIndex withString:(NSString *)mString;

/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)ObjectToData:(id)obj;
@end
