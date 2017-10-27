//
//  UIStoryboard+KDTK.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/4.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    static var splash: UIStoryboard {
        return UIStoryboard(name: "Splash", bundle: nil)
    }
    
    static var login: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    static var exam: UIStoryboard {
        return UIStoryboard(name: "Exam", bundle: nil)
    }
    static var course: UIStoryboard {
        return UIStoryboard(name: "Course", bundle: nil)
    }
    static var forum: UIStoryboard {
        return UIStoryboard(name: "Forum", bundle: nil)
    }
    static var me: UIStoryboard {
        return UIStoryboard(name: "Me", bundle: nil)
    }
    static var player: UIStoryboard {
        return UIStoryboard(name: "Player", bundle: nil)
    }
    
    struct Scene {
        // MARK: - 登录注册
//        static var loginPage: LoginVC {
//            return UIStoryboard.login.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        }
//        // MARK: - 题库
//        static var examHomePage: ExamHomePageVC {
//            return UIStoryboard.exam.instantiateViewController(withIdentifier: "ExamHomePageVC") as! ExamHomePageVC
//        }
//        
//        // MARK: - 课程
//        static var courseSegmentedPage: CourseSegmentedVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "CourseSegmentedVC") as! CourseSegmentedVC
//        }
//        static var courseHomePage: CourseHomePageVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "CourseHomePageVC") as! CourseHomePageVC
//        }
//        static var myCoursePage: MyCourseVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "MyCourseVC") as! MyCourseVC
//        }
//        static var searchCoursePage: SearchCourseVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "SearchCourseVC") as! SearchCourseVC
//        }
//        static var searchCourseResultPage: SearchCourseResultVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "SearchCourseResultVC") as! SearchCourseResultVC
//        }
//        static var allCoursePage: AllCourseVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "AllCourseVC") as! AllCourseVC
//        }
//        static var courseDetailSegmentedPage: CourseDetailSegmentedVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "CourseDetailSegmentedVC") as! CourseDetailSegmentedVC
//        }
//        static var courseDetailPage: CourseDetailVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "CourseDetailVC") as! CourseDetailVC
//        }
//        static var courseCataloguePage: CourseCatalogueVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "CourseCatalogueVC") as! CourseCatalogueVC
//        }
//        static var courseResourcePage: CourseResourceVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "CourseResourceVC") as! CourseResourceVC
//        }
//        static var teacherDetailPage: TeacherDetailVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "TeacherDetailVC") as! TeacherDetailVC
//        }
//        static var confirmOrderPage: ConfirmOrderVC {
//            return UIStoryboard.course.instantiateViewController(withIdentifier: "ConfirmOrderVC") as! ConfirmOrderVC
//        }
        // MARK: - 社区
//        static var forumHomePage: ForumHomePageVC {
//            return UIStoryboard.forum.instantiateViewController(withIdentifier: "ForumHomePageVC") as! ForumHomePageVC
//        }
        
        // MARK: - 我的
//        static var meHomePage: MeHomePageVC {
//            return UIStoryboard.me.instantiateViewController(withIdentifier: "MeHomePageVC") as! MeHomePageVC
//        }
        
        // MARK: - 播放器
//        static var playerPage: PlayerViewController {
//            return UIStoryboard.player.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
//        }
    }
}
