//
//  Util.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
    
    //判断是否为浮点形：
    
+ (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
    
+ (BOOL)checkNum:(NSString *)numStr{
    
    if( [self isPureInt:numStr] || [self isPureFloat:numStr]){
        
        return YES;
        
    }
    return NO;
}
    
    
+(BOOL)checkSFZ:(NSString *)numStr
    {
        if( numStr == nil || [numStr length] != 18 )
        {
            return NO;
        }
        
        char string_idnum[19];  // 身份证号码，最后一位留空，一会算出来最后一位
        
        char verifymap[] = "10X98765432";  // 加权乘积求和除以11的余数所对应的校验数
        
        int factor[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1};  // 加权因子
        
        long sum = 0l;  //加权乘积求和
        
        int m = 0;  // 加权乘积求和的模数
        
        char * p = string_idnum;  // 当前位置
        
        memset(string_idnum, 0, sizeof(string_idnum));  // 清零
        
        const char* snum = [numStr cStringUsingEncoding:NSASCIIStringEncoding];
        
        strcpy(string_idnum, snum);  // 本体码，也就是前17位
        string_idnum[17] = '\0';
        
        while(*p)  // 在 '\0' 之前一直成立
        
        {
            
            sum += (*p - '0') * factor[p - string_idnum];  // 加权乘积求和
            
            p++;  // 当前位置增加1
            
        }
        
        m = sum % 11;  // 取模
        
        return verifymap[m] == snum[17];
    }
+(NSDate*)dateWithInt:(double)second
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        return [date  dateByAddingTimeInterval: interval];
    }
+(NSString*)getTimeStringPointSecond:(double)second//2015.06.18. 12:12:00
    {
        return [Util getTimeStringPoint:[Util dateWithInt:second]];
    }
+(NSString*)getTimeStringHourSecond:(double)second
    {
        return [Util getTimeStringHour: [Util dateWithInt:second] ];
    }
    
+(NSString *)dateForint:(double)time bfull:(BOOL)bfull
    {
        NSDate *date = [Util dateWithInt:time];
        return [Util getTimeString:date bfull:bfull];
    }
+(NSString*)getTimeString:(NSDate*)dat bfull:(BOOL)bfull
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: bfull ? @"yyyy-MM-dd HH:mm:ss" : @"yyyy-MM-dd HH:mm" ];
        NSString *strDate = [dateFormatter stringFromDate:dat];
        if( bfull ) return strDate;
        
        //  NSString *nodatetring = [dateFormatter stringFromDate:[NSDate date]];
        return strDate;
    }
+ (NSString *)DateTimeInt:(int)time{
    
    NSDate *date = [Util dateWithInt:time];
    NSString *timeStr = [Util getTimeString:date bfull:NO];
    
    
    NSString *ss = timeStr;
    NSArray *a = [ss componentsSeparatedByString:@" "];
    NSString *s1 = [a objectAtIndex:0];
    
    NSArray *startTimeY = [s1 componentsSeparatedByString:@"-"];
    NSString *sm = [startTimeY objectAtIndex:1];
    NSString *sd = [startTimeY objectAtIndex:2];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[Util dateWithInt:time]];
    NSInteger wkd = [comps weekday];
    
    NSString* wdkstr = @"";
    switch (wkd) {
        case 1:
        wdkstr = @"日";
        break;
        case 2:
        wdkstr = @"一";
        break;
        case 3:
        wdkstr = @"二";
        break;
        case 4:
        wdkstr = @"三";
        break;
        case 5:
        wdkstr = @"四";
        break;
        case 6:
        wdkstr = @"五";
        break;
        case 7:
        wdkstr = @"六";
        break;
        default:
        break;
    }
    NSString *month = [NSString stringWithFormat:@"%@月%@日\n%@",sm,sd,wdkstr];
    return month;
    
    
}
+(NSString*)getTimeStringWithP:(double)time
    {
        NSDate *date = [Util dateWithInt:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        return [dateFormatter stringFromDate:date];
    }
    
+(NSString*)getTimeStringHour:(NSDate*)dat   //date转字符串 2015-03-23 08:00
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:dat];
    }
    
+(NSString*)getTimeStringNoYear:(NSDate*)dat   //date转字符串 2015-03-23 08:00
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
        return [dateFormatter stringFromDate:dat];
    }
    
+(NSString*)getTimeStringS:(NSDate*)dat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    return [dateFormatter stringFromDate:dat];
}
+(NSString*)getTimeStringSS:(NSDate*)dat   //date转字符串 20150415
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        return [dateFormatter stringFromDate:dat];
    }
    /**
     *  获取当前时间
     *
     *  @return 返回字符串
     */
+ (NSString *)getNowTime{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    MLLog(@"返回的时间是:%@",dateString);
    return dateString;
}
    
+ (NSString *)currentTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    MLLog(@"返回的时间是:%@",dateString);
    return dateString;
}
#pragma mark----*  比较2个时间的大小
    /**
     *  比较2个时间的大小
     *
     *  @param date01 时间1
     *  @param date02 时间2
     *
     *  @return 返回int
     */
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy:MM:dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
        //date02比date01大
        case NSOrderedAscending: ci=1; break;
        //date02比date01小
        case NSOrderedDescending: ci=-1; break;
        //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
    
}
    
+(NSString*)getTimeStringPoint:(NSDate*)dat   //date转字符串 2015.03.23 08:00:00
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        return [dateFormatter stringFromDate:dat];
    }
    
+(NSString *) FormartTime:(NSDate*) compareDate
    {
        
        if( compareDate == nil ) return @"";
        
        NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
        timeInterval = -timeInterval;
        long temp = timeInterval;
        NSString *result;
        
        if (timeInterval < 60) {
            if( temp == 0 )
            result = @"刚刚";
            else
            result = [NSString stringWithFormat:@"%d秒前",(int)temp];
        }
        else if(( timeInterval/60) <60){
            result = [NSString stringWithFormat:@"%d分钟前",(int)temp/60];
        }
        
        else if(( temp/86400) <30){
            
            NSDateFormatter *date = [[NSDateFormatter alloc] init];
            [date setDateFormat:@"dd"];
            NSString *str = [date stringFromDate:[NSDate date]];
            int nowday = [str intValue];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd"];
            NSString *strDate = [dateFormatter stringFromDate:compareDate];
            int day = [strDate intValue];
            if (nowday-day==0) {
                [dateFormatter setDateFormat:@"今天 HH:mm"];
                result =    [dateFormatter stringFromDate:compareDate];
            }
            else if(nowday-day==1)
            {
                
                [dateFormatter setDateFormat:@"昨天 HH:mm"];
                result =  [dateFormatter stringFromDate:compareDate];
                
                
            }
            
            
            else if( temp < 8 )
            {
                if (temp==1) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"昨天HH:mm"];
                    NSString *strDate = [dateFormatter stringFromDate:compareDate];
                    result = strDate;
                }
                else if(temp == 2)
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"前天HH:mm"];
                    NSString *strDate = [dateFormatter stringFromDate:compareDate];
                    result = strDate;
                }
                
            }
            else
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM-dd HH:mm"];
                NSString *strDate = [dateFormatter stringFromDate:compareDate];
                result = strDate;
                
            }
        }
        else
        {//超过一个月的就直接显示时间了
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *strDate = [dateFormatter stringFromDate:compareDate];
            result = strDate;
        }
        
        /*
         else if((temp = (temp/(3600*24))/30) <12){
         result = [NSString stringWithFormat:@"%d个月前",(int)temp];
         }
         else{
         temp = temp/12;
         result = [NSString stringWithFormat:@"%d年前",(int)temp];
         }
         */
        
        return  result;
    }
    
    
+(UIImage*)scaleImg:(UIImage*)org maxsizeW:(CGFloat)maxW //缩放图片,,最大多少
    {
        
        UIImage* retimg = nil;
        
        CGFloat h;
        CGFloat w;
        
        if( org.size.width > maxW )
        {
            w = maxW;
            h = (w / org.size.width) * org.size.height;
        }
        else
        {
            w = org.size.width;
            h = org.size.height;
            return org;
        }
        
        UIGraphicsBeginImageContext( CGSizeMake(w, h) );
        
        [org drawInRect:CGRectMake(0, 0, w, h)];
        retimg = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return retimg;
    }
    
    //缩放图片
+(UIImage*)scaleImg:(UIImage*)org maxsize:(CGFloat)maxsize
    {
        
        UIImage* retimg = nil;
        
        CGFloat h;
        CGFloat w;
        if( org.size.width > org.size.height )
        {
            if( org.size.width > maxsize )
            {
                w = maxsize;
                h = (w / org.size.width) * org.size.height;
            }
            else
            {
                w = org.size.width;
                h = org.size.height;
                return org;
            }
        }
        else
        {
            if( org.size.height > maxsize )
            {
                h = maxsize;
                w = (h / org.size.height) * org.size.width;
            }
            else
            {
                w = org.size.width;
                h = org.size.height;
                return org;
            }
        }
        
        UIGraphicsBeginImageContext( CGSizeMake(w, h) );
        
        [org drawInRect:CGRectMake(0, 0, w, h)];
        retimg = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return retimg;
    }
    
    
+(void)autoExtendH:(UIView*)tagview dif:(CGFloat)dif
    {//寻找所有子view,最底部的那个
        
        CGFloat offset = 0.0f;
        BOOL b = NO;
        for( UIView* one in tagview.subviews )
        {
            if( one.hidden ) continue;
            b = YES;
            CGFloat t   = one.frame.origin.y + one.frame.size.height;
            offset = t > offset ? t :offset;
        }
        
        if( !b ) return;
        
        CGRect f = tagview.frame;
        f.size.height = offset + dif;
        tagview.frame = f;
    }
+(void)autoExtendH:(UIView*)tagview blow:(UIView*)subview dif:(CGFloat)dif
    {
        CGRect f = tagview.frame;
        
        f.size.height = subview.frame.origin.y + subview.frame.size.height + dif;
        
        tagview.frame = f;
    }
    
    
    
+(BOOL)checkPasswdPre:(NSString *)passwd
    {
        if (passwd.length<6||passwd.length>20) {
            return NO;
        }
        return YES;
    }
    
    /*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum
    {
        
        if (mobileNum.length <= 0)
        {
            return NO;
        }
        
        NSString *phoneRegex = @"\\b(1)[34578][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        return [phoneTest evaluateWithObject:mobileNum];
    }
    
+ (BOOL)verifyMobile:(NSString *)mobileNum
    
    {
        
        if (mobileNum.length != 11)
        {
            return NO;
        }
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
         * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         * 联通号段: 130,131,132,155,156,185,186,145,176,1709
         * 电信号段: 133,153,180,181,189,177,1700
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         */
        NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        /**
         * 中国联通：China Unicom
         * 130,131,132,155,156,185,186,145,176,1709
         */
        NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        /**
         * 中国电信：China Telecom
         * 133,153,180,181,189,177,1700
         */
        NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
        
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        NSPredicate *regextesphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        
        if (([regextestmobile evaluateWithObject:mobileNum] == YES)
            || ([regextestcm evaluateWithObject:mobileNum] == YES)
            || ([regextestct evaluateWithObject:mobileNum] == YES)
            || ([regextestcu evaluateWithObject:mobileNum] == YES)
            || ([regextesphs evaluateWithObject:mobileNum] == YES))
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    
    
    
    
+(BOOL)checkIdentityCardNo:(NSString*)cardNo
    {
        if (cardNo.length != 18) {
            return  NO;
        }
        NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
        NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
        
        NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
        
        int val;
        BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
        if (!isNum) {
            return NO;
        }
        int sumValue = 0;
        
        for (int i =0; i<17; i++) {
            sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
        }
        
        NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
        
        if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
            return YES;
        }
        return  NO;
    }
    
+ (BOOL)checkBankCard:(NSString*)bankCard{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[bankCard length];
    int lastNum = [[bankCard substringFromIndex:cardNoLength-1] intValue];
    
    bankCard = [bankCard substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCard substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
    return YES;
    else
    return NO;
}
    
+(NSDictionary*)delNUll:(NSDictionary*)dic
    {
        NSArray* allk = dic.allKeys;
        NSMutableDictionary* tmp = NSMutableDictionary.new;
        for ( NSString* onek in allk ) {
            id v = [dic objectForKey:onek];
            if( [v isKindOfClass:[NSNull class] ] )
            {//如果是nsnull 不要
                continue;
            }
            
            if( [v isKindOfClass:[NSArray class]] || [v isKindOfClass: [NSMutableArray class]] )
            {
                NSArray* ta = [Util delNullInArr:v] ;
                [tmp setObject:ta forKey:onek];
                continue;
            }
            if( [v isKindOfClass:[NSDictionary class]] || [v isKindOfClass:[NSMutableDictionary class]] )
            {
                NSDictionary* td = [Util delNUll:v];
                [tmp setObject:td forKey:onek];
                continue;
            }
            [tmp setObject:v forKey:onek];
        }
        return tmp;
    }
+(NSArray*)delNullInArr:(NSArray*)arr
    {
        NSMutableArray* tmp = NSMutableArray.new;
        for ( id v in arr ) {
            if( [v isKindOfClass:[NSNull class] ] )
            {//如果是nsnull 不要
                continue;
            }
            if( [v isKindOfClass:[NSArray class]] || [v isKindOfClass: [NSMutableArray class]] )
            {
                NSArray* ta = [Util delNullInArr:v] ;
                [tmp addObject:ta];
                continue;
            }
            if( [v isKindOfClass:[NSDictionary class]] || [v isKindOfClass:[NSMutableDictionary class]] )
            {
                NSDictionary* td = [Util delNUll:v];
                [tmp addObject:td];
                continue;
            }
            [tmp addObject:v];
        }
        return tmp;
    }
    
+(UIColor*)stringToColor:(NSString*)str
    {
        if( str.length != 7 ) return nil;
        //#54fd13
        NSString* r = [str substringWithRange:NSMakeRange(1, 2)];
        unsigned long rv = strtoul( [r UTF8String] , NULL, 16);
        
        NSString* g = [str substringWithRange:NSMakeRange(3, 2)];
        unsigned long gv = strtoul( [g UTF8String] , NULL, 16);
        
        NSString* b = [str substringWithRange:NSMakeRange(5, 2)];
        unsigned long bv = strtoul( [b UTF8String] , NULL, 16);
        
        return ColorRGB(rv,gv,bv);
    }
    
+(NSString*)getDistStr:(int)dist
    {
        if( dist < 1000 )
        return [NSString stringWithFormat:@"%dm",dist];
        else if( dist < 1000*100 )
        return [NSString stringWithFormat:@"%dkm",dist/1000];
        else
        return @">100km";
    }
    
    //MARK: sign
+ (NSString *)genWxSign:(NSDictionary *)signParams parentkey:(NSString*)parentkey
    {
        // 排序
        NSArray *keys = [signParams allKeys];
        NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        // 生成
        NSMutableString *sign = [NSMutableString string];
        for (NSString *key in sortedKeys) {
            [sign appendString:key];
            [sign appendString:@"="];
            [sign appendString:[signParams objectForKey:key]];
            [sign appendString:@"&"];
        }
        [sign appendFormat:@"key=%@",parentkey];
        
        return  [[Util md5:sign] uppercaseString];
    }
    
    //MARK: sign
+ (NSString *)genWXClientSign:(NSDictionary *)signParams
    {
        // 排序
        NSArray *keys = [signParams allKeys];
        NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        // 生成
        NSMutableString *sign = [NSMutableString string];
        for (NSString *key in sortedKeys) {
            [sign appendString:key];
            [sign appendString:@"="];
            [sign appendString:[signParams objectForKey:key]];
            [sign appendString:@"&"];
        }
        NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
        
        return [Util sha1:signString];;
    }
    
    
    //requrl http://api.fun.com/getxxxx
    //
+(NSString*)makeURL:(NSString*)requrl param:(NSDictionary*)param
    {
        if( param.count == 0 ) return requrl;
        
        NSArray* allk = param.allKeys;
        NSMutableString* reqstr = NSMutableString.new;
        for ( NSString* onek in allk ) {
            [reqstr appendFormat:@"%@=%@&",onek,param[onek]];
        }
        return [NSString stringWithFormat:@"%@?%@",requrl,[reqstr substringToIndex:reqstr.length-2]];
    }
    
    //生成XML
+(NSString*)makeXML:(NSDictionary*)param
    {
        if( param.count == 0 ) return @"";
        
        NSArray* allk = param.allKeys;
        NSMutableString* reqstr = NSMutableString.new;
        [reqstr appendString:@"<xml>\n"];
        for ( NSString* onek in allk ) {
            [reqstr appendFormat:@"<%@>%@</%@>\n",onek,param[onek],onek];
        }
        [reqstr appendString:@"</xml>"];
        return reqstr;
    }
    
+(NSString*)getAppVersion
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    
    
    
    /*
     + (NSString *)getIPAddress:(BOOL)preferIPv4
     {
     NSArray *searchArray = preferIPv4 ?
     @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
     @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
     
     NSDictionary *addresses = [self getIPAddresses];
     //NSLog(@"addresses: %@", addresses);
     
     __block NSString *address;
     [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
     address = addresses[key];
     if(address) *stop = YES;
     } ];
     return address ? address : @"0.0.0.0";
     }
     
     + (NSDictionary *)getIPAddresses
     {
     NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
     
     // retrieve the current interfaces - returns 0 on success
     struct ifaddrs *interfaces;
     if(!getifaddrs(&interfaces)) {
     // Loop through linked list of interfaces
     struct ifaddrs *interface;
     for(interface=interfaces; interface; interface=interface->ifa_next) {
     if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
     continue; // deeply nested code harder to read
     }
     const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
     if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
     NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
     char addrBuf[INET6_ADDRSTRLEN];
     if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
     NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
     addresses[key] = [NSString stringWithUTF8String:addrBuf];
     }
     }
     }
     // Free memory
     freeifaddrs(interfaces);
     }
     
     // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
     return [addresses count] ? addresses : nil;
     }
     
     */
    
+(int)gettopestV:(int)v
    {
        int r = v;
        while ( r > 10 )
        {
            r  = r/10;
        }
        return r;
    }
    
    
+(NSString*)URLEnCode:(NSString*)str
    {
        NSString *resultStr = str;
        
        CFStringRef originalString = (__bridge CFStringRef) str;
        CFStringRef leaveUnescaped = CFSTR(" ");
        CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
        
        CFStringRef escapedStr;
        escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                             originalString,
                                                             leaveUnescaped,
                                                             forceEscaped,
                                                             kCFStringEncodingUTF8);
        
        if( escapedStr )
        {
            NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
            CFRelease(escapedStr);
            
            // replace spaces with plusses
            [mutableStr replaceOccurrencesOfString:@" "
                                        withString:@"%20"
                                           options:0
                                             range:NSMakeRange(0, [mutableStr length])];
            resultStr = mutableStr;
        }
        return resultStr;
    }
    
+(NSString*)URLDeCode:(NSString*)str
    {
        return [[str      stringByReplacingOccurrencesOfString:@"+" withString:@" "]
                stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    //20150416 => 4月16日
+(NSString*)convdatestr:(NSString*)str
    {
        if( str.length == 8 )
        {
            NSString* m = [str substringWithRange:NSMakeRange(4, 2)];
            NSString* d = [str substringWithRange:NSMakeRange(6, 2)];
            
            return [NSString stringWithFormat:@"%@月%@日",m,d];
        }
        return str;
    }
    
    
+ (NSString *)startTimeStr:(NSString *)startTime andEndTime:(NSString *)endTime{
    NSString *ss = startTime;
    NSArray *a = [ss componentsSeparatedByString:@" "];
    NSString *s1 = [a objectAtIndex:0];
    NSString *s2 = [a objectAtIndex:1];
    
    NSArray *startTimeY = [s1 componentsSeparatedByString:@"-"];
    NSString *sm = [startTimeY objectAtIndex:1];
    NSString *sd = [startTimeY objectAtIndex:2];
    
    NSArray *startTimeH = [s2 componentsSeparatedByString:@":"];
    NSString *sh = [startTimeH objectAtIndex:0];
    NSString *sc = [startTimeH objectAtIndex:1];
    
    NSString *LsTime = [NSString stringWithFormat:@"%@/%@ %@:%@",sm,sd,sh,sc];
    
    
    
    NSString *sss = endTime;
    NSArray *a1 = [sss componentsSeparatedByString:@" "];
    NSString *s3 = [a1 objectAtIndex:0];
    NSString *s4 = [a1 objectAtIndex:1];
    
    NSArray *endTimeY = [s3 componentsSeparatedByString:@"-"];
    NSString *em = [endTimeY objectAtIndex:1];
    NSString *ed = [endTimeY objectAtIndex:2];
    
    NSArray *endTimeH = [s4 componentsSeparatedByString:@":"];
    NSString *eh = [endTimeH objectAtIndex:0];
    NSString *ec = [endTimeH objectAtIndex:1];
    
    NSString *LeTime = [NSString stringWithFormat:@"%@/%@ %@:%@",em,ed,eh,ec];
    
    NSString *TT = [NSString stringWithFormat:@"%@-%@",LsTime,LeTime];
    return TT;
}
+ (NSString *)startTimeStr:(NSString *)startSS{
    
    if (startSS.length == 0) {
        return startSS;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date2 =  [dateFormatter dateFromString:startSS];
    
    
    NSString* dateNow;
    dateNow = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *date1 = [dateFormatter dateFromString:dateNow];
    
    if ([date1 isEqualToDate:date2]) {
        return @"今天";
    }
    else if ([[date1 dateByAddingTimeInterval:86400] isEqualToDate:date2]) {
        return @"明天";
    }
    else if ([[date1 dateByAddingTimeInterval:86400*2]isEqualToDate:date2])
    {
        return @"后天";
    }else{
        return [[startSS substringFromIndex:6] stringByAppendingString:@"号"];
    }
    
}
    
+ (CGFloat)labelText:(NSString *)s fontSize:(CGFloat)fsize labelWidth:(CGFloat)width{
    UIFont *font = [UIFont systemFontOfSize:fsize];
    CGSize size  = CGSizeMake(width,2000);
    
    //    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    //    CGSize labelsize    = CGSizeZero;
    //    if (systemVersion >= 7.0){
    //        NSDictionary *tdic =  [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    //        labelsize = [s boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    //    }else {
    //        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    //    }
    
    
    size.height = [s boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size.height;
    
    return size.height;
}
+ (NSString *)mFirstStr:(NSString *)mFirstStr andSecondStr:(NSString *)secondStr{
    
    NSString *ss = mFirstStr;
    NSArray *a = [ss componentsSeparatedByString:@" "];
    NSString *s1 = [a objectAtIndex:0];
    NSString *s2 = [a objectAtIndex:1];
    
    NSArray *startTimeY = [s1 componentsSeparatedByString:@"-"];
    NSString *sm = [startTimeY objectAtIndex:1];
    NSString *sd = [startTimeY objectAtIndex:2];
    
    NSString *month = [NSString stringWithFormat:@"%@月%@日",sm,sd];
    
    NSString *ss8 = secondStr;
    NSArray *ssss1 = [ss8 componentsSeparatedByString:@" "];
    NSString *s20 = [ssss1 objectAtIndex:1];
    
    NSString *tt = [NSString stringWithFormat:@"%@ %@-%@",month,s2,s20];
    
    return tt;
    
}
+ (int)mTimeToInt:(NSDate *)dateStr{
    
    int finalitime = [[NSString stringWithFormat:@"%f",[dateStr timeIntervalSince1970]]intValue]-3600*8;
    return finalitime;
}
+ (NSString *)mDuration:(int)Duration{
    
    int hour =  Duration/3600;
    int munite = Duration/60%60;
    
    int mm = Duration/60;
    
    NSString *str = nil;
    if (mm >= 60) {
        str = [NSString stringWithFormat:@"%d小时%d分钟",hour,munite];
    }
    if (mm<=60) {
        str = [NSString stringWithFormat:@"%d分钟",munite];
    }
    
    return str;
}
+(NSMutableAttributedString *)labelWithUnderline:(NSString *)mString{
    NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", mString]];
    NSRange phoneRange = {0,[phoneStr length]};
    [phoneStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:phoneRange];
    return phoneStr;
}
    
    
+ (NSString *)mStartTimeArr:(NSArray *)Sarr andmEndTimeArr:(NSArray *)Earr{
    
    NSMutableArray  *tempArr = [NSMutableArray new];
    
    for (int i = 0;i<Sarr.count;i++) {
        NSString *string = [NSString stringWithFormat:@"%@-%@",Sarr[i],Earr[i]];
        [tempArr addObject:string];
        
    }
    NSString *ArrStr = [NSString stringWithFormat:@"%@",tempArr];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    ArrStr = [[ArrStr componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    
    MLLog(@"/-------------%@---------------/",ArrStr);
    return ArrStr;
}
+ (UIImage *)imageFromView: (UIView *) theView
    {
        
        UIGraphicsBeginImageContext(theView.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [theView.layer renderInContext:context];
        UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return theImage;
    }
    ///时间date转时间戳
+ (int)DateToInt:(NSString *)date{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:date];
    NSLog(@"date = %@", inputDate);
    
    int finalitime = [[NSString stringWithFormat:@"%f",[inputDate timeIntervalSince1970]]intValue];
    return finalitime;
    
}
    
    ///2个时间比较大小
+ (NSDate *)CompareTime:(NSString *)mTimeStr{
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"HH:mm"];
    NSDate* date1 = [formater dateFromString:mTimeStr];
    NSLog(@"第一个时间：%@", date1);
    return date1;
    
}
+ (NSString *)getAPPName{
    
    NSString *AppName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
    
    return AppName;
    
}
+ (NSString *)getAppSchemes{
    NSString* File = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithContentsOfFile:File];
    
    NSString *str = nil;
    NSMutableArray *tempArr = [NSMutableArray new];
    for (NSDictionary *dic in [dict objectForKey:@"CFBundleURLTypes"]) {
        str  = [dic objectForKey:@"CFBundleURLSchemes"];
        [tempArr addObject:str];
    }
    return tempArr[0];
}
    
    
    
+ (NSString *)getDeviceModel{
    
    //    NSString* phoneModel = [[UIDevice currentDevice] model];
    //
    //    return phoneModel;
    
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    else{
        
        deviceString = @"ipad";
    }
    return deviceString;
    
}
    
+ (NSString *)getDeviceVersion{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleShortVersionString"];
    
    return versionNum;
}
    
#pragma mark----获取设备build号
    /**
     *  获取设备build号
     *
     *  @return 返回字符串
     */
+ (NSString *)getAPPBuildNum{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    
    return versionNum;
    
}
    /*!
     * @brief 把格式化的JSON格式的字符串转换成字典
     * @param jsonString JSON格式的字符串
     * @return 返回字典
     */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
    
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
    
    {
        
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
#pragma mark----数组转json字符串
    /**
     数组转json
     
     @param arr 转换的数组
     @return 返回json字符串
     */
+ (NSString *)arrToJson:(NSArray *)arr{
    NSError *parseError = nil;
    
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:arr
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&parseError];
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
}
+ (CGFloat)labelTextWithWidth:(NSString *)str{
    CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:14]];
    return strsize.width;
    
}
+ (CGSize)boundingRectWithSize:(CGSize)size andStr:(NSString *)str
    {
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        
        CGSize retSize = [str boundingRectWithSize:size
                                           options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
        
        return retSize;
    }
    
    
+ (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}
#pragma mark----过滤emoji表情
    /**
     *  过滤emoji表情
     *
     *  @param string 传入字符串
     *
     *  @return 返回过滤后的字符串
     */
+ (NSString *)filterEmoji:(NSString *)string {
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [string UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}
    
#pragma mark----富文本处理
    /**
     *  富文本处理
     *
     *  @param mContent 要处理的文本内容
     *
     *  @return 返回富文本内容
     */
+ (NSMutableAttributedString *)WKLabelWithAttributString:(NSString *)mContent andColorText:(NSString *)mColorTex
    {
        NSString *inteStr = [NSString stringWithFormat:@"%@%@",mContent,mColorTex];
        
        NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:inteStr];
        
        NSRange orangeRange = NSMakeRange([[inteMutStr string] rangeOfString:mColorTex].location, [[inteMutStr string] rangeOfString:mColorTex].length);
        [inteMutStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:orangeRange];
        
        return inteMutStr;
    }
    
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
    {
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];
        UIImage *img = [UIImage imageWithCGImage:imgRef
                                           scale:assetRep.scale
                                     orientation:(UIImageOrientation)assetRep.orientation];
        return img;
    }
    
    
#pragma mark----截取字符串
    /**
     截取字符串第几位
     
     @param mText  要截取的内容
     @param mLocation 从第几位开始截取
     @param mLength 要截取的长度
     
     @return 返回结果
     */
+ (NSString *)ZLCutStringWithText:(NSString *)mText andRangeWithLocation:(NSInteger)mLocation andRangeWithLength:(NSInteger)mLength{
    
    return [mText substringWithRange:NSMakeRange(mLocation, mLength)];
}
    
    ///是否有优惠券
+ (BOOL)iscoupon:(int)mCoupon{
    
    if (mCoupon == 0) {
        return YES;
        
    }else{
        return NO;
        
    }
    
}
#pragma mark---- 字符串替换
    /**
     字符串替换
     
     @param mBaseString 原字符串
     @param mWillRepStr 将要替换的字符串
     @param mToRepStr 替换为神马字符串
     @return 返回替换后的字符串
     */
+ (NSString *)ZLReplaceString:(NSString *)mBaseString andWillFromReplaceStr:(NSString *)mWillRepStr andToReplaceStr:(NSString *)mToRepStr{
    
    
    return [mBaseString stringByReplacingOccurrencesOfString:mWillRepStr withString:mToRepStr];
    
}
    
#pragma mark----删除字典里的null值
+ (NSDictionary *)deleteEmpty:(NSDictionary *)dic
    {
        NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        NSMutableArray *set = [[NSMutableArray alloc] init];
        NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
        for (id obj in mdic.allKeys)
        {
            id value = mdic[obj];
            if ([value isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *changeDic = [self deleteEmpty:value];
                [dicSet setObject:changeDic forKey:obj];
            }
            else if ([value isKindOfClass:[NSArray class]])
            {
                NSArray *changeArr = [self deleteEmptyArr:value];
                [arrSet setObject:changeArr forKey:obj];
            }
            else
            {
                if ([value isKindOfClass:[NSNull class]]) {
                    [set addObject:obj];
                }
            }
        }
        for (id obj in set)
        {
            mdic[obj] = @"";
        }
        for (id obj in dicSet.allKeys)
        {
            mdic[obj] = dicSet[obj];
        }
        for (id obj in arrSet.allKeys)
        {
            mdic[obj] = arrSet[obj];
        }
        
        return mdic;
    }
    
#pragma mark----删除数组中的null值
+ (NSArray *)deleteEmptyArr:(NSArray *)arr
    {
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        NSMutableArray *set = [[NSMutableArray alloc] init];
        NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
        
        for (id obj in marr)
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *changeDic = [self deleteEmpty:obj];
                NSInteger index = [marr indexOfObject:obj];
                [dicSet setObject:changeDic forKey:@(index)];
            }
            else if ([obj isKindOfClass:[NSArray class]])
            {
                NSArray *changeArr = [self deleteEmptyArr:obj];
                NSInteger index = [marr indexOfObject:obj];
                [arrSet setObject:changeArr forKey:@(index)];
            }
            else
            {
                if ([obj isKindOfClass:[NSNull class]]) {
                    NSInteger index = [marr indexOfObject:obj];
                    [set addObject:@(index)];
                }
            }
        }
        for (id obj in set)
        {
            marr[(int)obj] = @"";
        }
        for (id obj in dicSet.allKeys)
        {
            int index = [obj intValue];
            marr[index] = dicSet[obj];
        }
        for (id obj in arrSet.allKeys)
        {
            int index = [obj intValue];
            marr[index] = arrSet[obj];
        }
        return marr;
    }
    
#pragma mark----判断是否为url
    /**
     判断是否为url
     
     @param mString 要判断的字符串
     @return 返回bool值
     */
+ (BOOL)isUrl:(NSString *)mString
    {
        if(mString == nil)
        return NO;
        //    NSString *url;
        //    if (mString.length>4 && [[mString substringToIndex:4] isEqualToString:@"http"]) {
        //        url = [NSString stringWithFormat:@"http://%@",mString];
        //    }else{
        //        url = mString;
        //    }
        //    NSString *urlRegex = @"(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}";
        //    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
        //    return [urlTest evaluateWithObject:url];
        
        NSString *regex =@"[a-zA-z]+://[^\\s]*";
        NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [urlTest evaluateWithObject:mString];
    }
    

    
    
#pragma mark---- 字符串过滤
    /**
     字符串过滤
     
     @param mCharaString 要过滤
     @return 返回过滤后的字符串
     */
+ (NSString *)ZLCharacterString:(NSString *)mCharaString{
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    
    return [self ZLReplaceString:[mCharaString stringByTrimmingCharactersInSet:set] andWillFromReplaceStr:@"    " andToReplaceStr:@""];
    
}
    
#pragma mark---- 字符串判断
    /**
     判断是否包含字符串
     
     @param mString 要判断的字符串
     @return 返回yes or no
     */
+ (BOOL)ZLRangOfString:(NSString *)mString{
    
    
    if ([mString isEqualToString:@"/ppao/ppao_load"]) {
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_order_list"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_evaluate"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_revenue"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/order_task"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_sort"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_apply"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/order_oprate"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/order_diff"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_order_info"]){
        return YES;
        
    }else if ([mString isEqualToString:@"/ppao/ppao_location"]){
        return YES;
        
    }else {
        return NO;
    }
    
}
    
    
//#pragma mark----  返回当前图片url
//    /**
//     返回当前图片url
//     
//     @param mUrl 图片的url
//     @return 返回图片的URL
//     */
//+ (NSString *)currentSourceImgUrl:(NSString *)mUrl{
//    if (mUrl.length > 0)
//    return [NSString stringWithFormat:@"%@/%@",kAFAppDotNetImgBaseURLString,[mUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    return @"";
//}
#pragma mark----字符串拼接成数组
    /**
     字符串拼接成数组
     
     @param string 要转换的字符串
     @return 返回数组
     */
+ (NSArray *)wk_StringToArr:(NSString *)string{
    
    NSMutableArray *mImgArr = [NSMutableArray new];
    
    if (string.length<=0 || [string isEqualToString:@""]) {
        return nil;
    }else{
        
        NSArray *mArr = [string componentsSeparatedByString:@","];
        
        for (int i = 0; i<mArr.count; i++) {
            NSString *mImgStr = mArr[i];
            
            if (mImgStr.length>0) {
                [mImgArr addObject:mImgStr];
            }
        }
        return mImgArr;
    }
    
}
#pragma mark----字符串替换
    /**
     字符串替换
     
     @param oldString 原字符
     @param tagString 要替换的字符
     @return 返回字符
     */
+ (NSString *)wk_stringReplaceString:(NSString *)oldString andTag:(NSString *)tagString{
    
    if (oldString.length<=0 || [oldString isEqualToString:@""]) {
        return nil;
    }else{
        
        NSArray *mStrArr = [oldString componentsSeparatedByString:tagString];
        NSString *currentString = @"";
        for (int i = 0; i<mStrArr.count; i++) {
            NSString *mSubString = mStrArr[i];
            
            if (mSubString.length>0) {
                currentString = [currentString stringByAppendingString:mSubString];
            }
        }
        return currentString;
    }
}
+ (void)ZLSaveLocalData:(id)mData withKey:(NSString *)mKey{
    NSData *mdata = [NSKeyedArchiver archivedDataWithRootObject:mData];
    NSUserDefaults *mAdd = [NSUserDefaults standardUserDefaults];
    [mAdd setObject:mdata forKey:mKey];
    
}
    
+ (NSData *)ZLGetLocalDataWithKey:(NSString *)mKey{
    NSUserDefaults *mAdd = [NSUserDefaults standardUserDefaults];
    return [NSKeyedUnarchiver unarchiveObjectWithData:[mAdd objectForKey:mKey]];
}
    
#pragma mark----字符串截取
    /**
     字符串截取
     
     @param mIndex 下标
     @param mString 要截取的字符串
     @return 返回字符串
     */
+ (NSString *)wk_stringToSubString:(NSInteger)mIndex withString:(NSString *)mString{
    
    return [NSString stringWithFormat:@"%@-%@",[mString substringToIndex:mIndex],[mString substringFromIndex:mIndex]];
    
}
    
/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)ObjectToData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}

+ (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self ObjectToData:obj];
    
}
@end
