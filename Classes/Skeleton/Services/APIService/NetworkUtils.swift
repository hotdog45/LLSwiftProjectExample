//
//  NetworkUtils.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/3.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

// MARK: - --题库模块--
final class ExamAPI {
    /***    小组测试挑战详情  [/zone/group/paper/detail.htm]    ***/
    public static let  ZoneGroupPaperDetail = "/zone/group/paper/detail.htm"
    
    /***    咨询师 [/msg/counselor.htm]    ***/
    public static let  MsgCounselor = "/msg/counselor.htm"
    
    /***    搜索、题目    ***/
    public static let  ExamitemSearch = "/examitem/search.htm"
    
    /***    随机礼包[/channel/sendH5GiftPack.htm]    ***/
    public static let  ChannelSendH5GiftPack = "/channel/sendH5GiftPack.htm"
    
    /***    随机提示语[/tips/random.htm]    ***/
    public static let  TipsRandom = "/tips/random.htm"
    
    /***    课程详情[/chapter/detail.htm]    ***/
    public static let  ChapterDetail = "/chapter/detail.htm"
    
    /***    下次考研时间[/exam/date.htm]    ***/
    public static let  ExamDate = "/exam/date.htm"
    
    /***    题目详情 [/examitem/detail.htm]    ***/
    public static let  ExamitemDetail = "/examitem/detail.htm"
    
    /***    题库首页 [/exam/index.htm]    ***/
    public static let  ExamIndex = "/exam/index.htm"
    
    /***    题库首页V2 [/v2/exam/index.htm]    ***/
    public static let  ExamIndexV2 = "/v2/exam/index.htm"
    
    /***    排行榜 [/v2/best/exercise.htm]    ***/
    public static let  BestExerciseV2 = "/channel/exercise/rank.htm"
    
    /***    知识点列表 [/studyPoint/list.htm]    ***/
    public static let  studyPointList = "/studyPoint/list.htm"
    
    /***    知识点详情 [/studyPoint/detail.htm]    ***/
    public static let  studyPointDetail = "/studyPoint/detail.htm"
    
    /***    大纲列表V2[/channel/list.htm]    ***/
    public static let  ChannelListV2 = "/v2/channel/list.htm"
    
    /***    大纲列表[/channel/list.htm]    ***/
    public static let  ChannelList = "/channel/list.htm"
    
    /***    做题练习 [/exam/paper/create.htm]    ***/
    public static let  ExamPaperCreate = "/exam/paper/create.htm"
    
    /***    交卷 [/exam/paper/submit.htm]    ***/
    public static let  ExamPaperSubmit = "/exam/paper/submit.htm"
    
    /***    模块列表[/module/list.htm]    ***/
    public static let ModuleList = "/module/list.htm"
    
    /***    知识点列表 [/studyPoint/list.htm]    ***/
    public static let StudyPointList = "/studyPoint/list.htm"
    
    /***    知识点详情 [/studyPoint/detail.htm]    ***/
    public static let StudyPointDetail = "/studyPoint/detail.htm"
    
    /***    富文本素材 [/material/detail.htm]    ***/
    public static let MaterialList = "/material/list.htm"
    
    /***    笔记详情[/note/detail.htm]    ***/
    public static let NoteDetail = "/note/detail.htm"
    
    /***    试看笔记[/module/preview.htm]    ***/
    public static let ModulePreview = "/module/preview.htm"
    
    /***    购买模块[/module/buy.htm]    ***/
    public static let ModuleBuy = "/module/buy.htm"
    
    /***    分享解锁模块[/module/shareUnlock.htm]    ***/
    public static let ModuleShareUnlock = "/module/shareUnlock.htm"
    
    /***    试用板块[/studyTab/trial.htm]    ***/
    public static let StudyTabTrial = "/studyTab/trial.htm"
    
    /***    购买板块[/studyTab/buy.htm]    ***/
    public static let StudyTabBuy = "/studyTab/buy.htm"
    
    /***    试卷详情[/exam/paper/detail.htm]    ***/
    public static let ExamPaperDetail = "/exam/paper/detail.htm"
    
    /***    富文本素材 [/material/detail.htm]    ***/
    public static let MaterialDetail = "/material/detail.htm"
    
    /***    我的科目列表 [/member/subject/list.htm]   ***/
    public static let MemberSubjectList = "/member/subject/list.htm"
    
    /***    保存自定义科目 [/member/subject/custom.htm]    ***/
    public static let MemberSubjectCustom = "/member/subject/custom.htm"
    
    /***    自定义科目列表 [/subject/custom.htm]    ***/
    public static let SubjectCustom = "/subject/custom.htm"
    
}
// MARK: - --社区模块--
final class CommunityAPI {
    /***    [/im/token.htm]    ***/
    public static let IMToken = "/im/token.htm"
    
    /***    精选小组[/zone/group/list.htm]    ***/
    public static let ZoneGroupList = "/zone/group/list.htm"
    
    /***    加入小组[/zone/group/join.htm]    ***/
    public static let ZoneGroupJoin = "/zone/group/join.htm"
    
    /***    退出小组[/zone/group/quit.htm] ***/
    public static let ZoneGroupQuit = "/zone/group/quit.htm"

    /***    我的小组[/zone/member/groups.htm]    ***/
    public static let ZoneMemberGroups = "/zone/member/groups.htm"
    
    /***    小组成员[/zone/group/members.htm]    ***/
    public static let ZoneGroupMembers = "/zone/group/members.htm"
    
    /***    小组签到[/zone/group/signin.htm]    ***/
    public static let ZoneGroupSignin = "/zone/group/signin.htm"
    
    /***    小组签到面板[/zone/group/signin/board.htm]    ***/
    public static let ZoneGroupSigninBoard = "/zone/group/signin/board.htm"

    /***    小组签到排行榜[/zone/group/signin/rank.htm]    ***/
    public static let ZoneGroupSigninRank = "/zone/group/signin/rank.htm"
    
    /***    小组历史文章[/zone/group/article/list.htm]    ***/
    public static let ZoneGroupArticleList = "/zone/group/article/list.htm"
    
    /***    小组历史文件[/zone/group/file/list.htm]    ***/
    public static let ZoneGroupFileList = "/zone/group/file/list.htm"
    /***    写作宝hexin/passport.htm    ***/
    public static let HexinPassport = "/hexin/passport.htm"
    
    /***    小组测试挑战/zone/group/paper/list.htm    ***/
    public static let ZoneGroupPaperList = "/zone/group/paper/list.htm"
    
    /***    试卷刷题排行榜 ExamPaperExerciseRank    ***/
    public static let ExamPaperExerciseRank = "/exam/paper/exercise/rank.htm"
    
}



// MARK: - --我的模块--
final class MyAPI {

    
    /***    我的优惠券[/member/coupon/list.htm]    ***/
    public static let MemberCouponList = "/member/coupon/list.htm"
    
    /***     IAP充值 【 /iap/paid.htm 】    ***/
    public static let IapPaid = "/iap/paid.htm"
    
    /***     [/member/exercise/saveNum.htm]    ***/
    public static let MemberExerciseSaveNum = "/member/exercise/num.htm"
    
    /***    修改用户出题量 [/member/exercise/num/save.htm]    ***/
    public static let MemberExerciseNumSave = "/member/exercise/saveNum.htm"
    
    /***    base64上传 [/image/base64Upload.htm]    ***/
    public static let ImageBase64Upload = "/image/base64Upload.htm"
    
    /***    添加收藏[/member/favorite.htm]    ***/
    public static let MemberFavorite = "/member/favorite.htm"
    
    /***    取消收藏[/member/unfavorite.htm]    ***/
    public static let FavoriteUnfavorite = "/member/unfavorite.htm"
    
    /***    删除收藏[/member/favorite/remove.htm]    ***/
    public static let FavoriteRemove = "/member/favorite/remove.htm"
    
    /***    我的收藏[/member/favorite/list.htm]   ***/
    public static let FavoriteList = "/member/favorite/list.htm"
    
    /***    意见反馈 [/feedback.htm]   ***/
    public static let Feedback = "/feedback.htm"
    
    /***    个人信息 [/member/info.htm]    ***/
    public static let MemberInfo = "/member/info.htm"
    
    /***    设置头像 [/member/avatar.htm]    ***/
    public static let MemberAvatar = "/member/avatar.htm"
    
    /***    设置昵称 [#/member/nick.htm]    ***/
    public static let MemberNick = "/member/nickName.htm"
    
    /***    绑定手机号[/member/bindPhone.htm]    ***/
    public static let MemberBindPhone = "/member/bindPhone.htm"
    
    /***    个人账户信息 [/member/balance.htm]    ***/
    public static let MemberBalance = "/member/balance.htm"
    
    /***    获取用户所有收货地址[/addr/list.htm]    ***/
    public static let AddrList = "/addr/list.htm"
    
    /***    保存收货地址[/addr/save.htm]    ***/
    public static let AddrSave = "/addr/save.htm"
    
    /***    删除收货地址[/addr/remove.htm]    ***/
    public static let AddrRemove = "/addr/remove.htm"
    
    /***    获取单个收货地址[/addr/detail.htm]    ***/
    public static let AddrDetail = "/addr/detail.htm"
    
    /***    添加免费课堂[/member/course/subscribe.htm]   ***/
    public static let MemberCourseSubscribe = "/member/course/subscribe.htm"
    
    /***    课堂评分[/member/course/score.htm]    ***/
    public static let MemberCourseScore = "/member/course/score.htm"
    
    /***    订单列表 [/member/order/list.htm]    ***/
    public static let MemberOrderList = "/member/order/list.htm"
    
    /***    报考院校查询 [/apply/college.htm]    ***/
    public static let ApplyCollege = "/apply/college.htm"
    
    /***    报考专业查询 [/apply/major.htm]    ***/
    public static let ApplyMajor = "/apply/major.htm"
    
    /***    考试科目[/apply/subject.htm]    ***/
    public static let ApplySubject = "/apply/subject.htm"
    
    /***    保存报考信息[/application/save.htm]    ***/
    public static let ApplicationSave = "/application/save.htm"
    
    /***    我的报考信息[/application/detail.htm]    ***/
    public static let ApplicationDetail = "/application/detail.htm"
    
    /***    我的错题[/member/mistake.htm]    ***/
    public static let MemberMistake = "/member/mistake.htm"
    
    /***    删除错题[/member/mistake/remove.htm]    ***/
    public static let MemberMistakeRemove = "/member/mistake/remove.htm"
    
    /***    错题列表[/member/mistake/list.htm]    ***/
    public static let MemberMistakeList = "/member/mistake/list.htm"
    
    /***   订单红包详情[/order/coupon/detail.htm]     ***/
    public static let HotCollegeList = "/hot/college/list.htm"
}
// MARK: - --课堂模块--
final  class CourseAPI {
    
    
    
    /***   订单红包详情[/order/coupon/detail.htm]     ***/
    public static let OrderCouponDetail = "/order/coupon/detail.htm"
    
    /***   可用优惠券列表[/member/coupon/select.htm]     ***/
    public static let MemberCouponSelect = "/member/coupon/select.htm"
    
    /***        ***/
    public static let CourseResourceDetail = "/course/resource/detail.htm"
    /***      ***/
    public static let ChapterWatch = "/chapter/watch.htm"
    
    /***    热门课堂    ***/
    public static let Hot = "/course/hot.htm"
    
    /***    课堂列表    ***/
    public static let List = "/course/list.htm"
    
    /***    我的课堂    ***/
    public static let MemberCourseList = "/member/course/list.htm"
    
    /***    名师推荐    ***/
    public static let TeacherHot = "/teacher/hot.htm"
    
    /***    广告轮播    ***/
    public static let AdList = "/ad/list.htm"
    
    /***    获取老师信息    ***/
    public static let TeacherDetail = "/teacher/detail.htm"
    
    /***    获取老师的热门课程   ***/
    public static let TeacherHotCourses = "/teacher/hotcourses.htm"
    
    /***    获取课堂详细信息    ***/
    public static let CourseDetail = "/v2/course/detail.htm"
    
    /***    获取课程目录音视频信息    ***/
    public static let Media = "/course/chapter/media.htm"
    
    /***    课程目录    ***/
    public static let CourseChapters = "/course/chapters.htm"
    
    /***    课堂来源    ***/
    public static let  CourseSource = "/course/source.htm"
    
    /***    课堂来源    ***/
    public static let  CourseSorts = "/course/sorts.htm"
    
    /***    课堂年份    ***/
    public static let  CourseYears = "/course/years.htm"
    
    /***    课堂分类    ***/
    public static let  CourseCategories = "/course/categories.htm"
    
    /***    为你定制    ***/
    public static let  CourseCustom = "/course/custom.htm"
    
    /***    获取热门搜索关键字    ***/
    public static let  HotSearch = "/hotsearch.htm"
    
    /***    搜索知识点、题目、课堂    ***/
    public static let  CourseSearch = "/course/search.htm"
    
    /***    优惠券  ***/
    public static let  CourseSales = "/course/sales.htm"
    
    /***    快递列表    ***/
    public static let  ExpressList = "/express/list.htm"
    
    /***    确认下单    ***/
    public static let  OrderSubmit = "/order/submit.htm"
    
    /***    支付    ***/
    public static let  OrderPay = "/order/pay.htm"
    
}

// MARK: - --登录模块--
final class LoginAPI {
    /***    账号登录    ***/
    public static let Login = "/login.htm"
    
    /***    三方登录    ***/
    public static let Auth2Login = "/auth2Login.htm"
    
    /***    忘记密码   ***/
    public static let FindPwd = "/findPwd.htm"
    
    /***    发送验证码   ***/
    public static let SendCode = "/sendCode.htm"
    
    /***    注册   ***/
    public static let Register = "/register.htm"
    
    /***    退出登陆 [/logout.htm]   ***/
    public static let Logout = "/logout.htm"
    
    /***    ban本号  [/version/info.htm]   ***/
    public static let VersionInfo = "/version/info.htm"
    
}















